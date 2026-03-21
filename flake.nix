{
  description = "A flake for managing development environments.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-lima = {
      url = "github:nixos-lima/nixos-lima";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-droid.url = "github:NixOS/nixpkgs/nixos-24.05";
    # NOTE: workaround nix-community/nix-on-droid#495
    nixpkgs-unstable-droid.url = "github:NixOS/nixpkgs/88d3861";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-droid";
    };

    mcp-hub = {
      url = "github:ravitemer/mcp-hub";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs = {
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs =
    inputs@{
      self,
      systems,
      flake-parts,
      ...
    }:
    let
      overlayed-pkgs =
        { system, ... }:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            inputs.neovim-nightly.overlays.default
          ];
        };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks-nix.flakeModule
      ];
      systems = import systems;
      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = overlayed-pkgs {
            inherit system;
          };
          packages = rec {
            falco = pkgs.callPackage ./nix/pkgs/tools/falco { };
            fennel-ls = pkgs.callPackage ./nix/pkgs/tools/fennel-ls { };
            rq = pkgs.callPackage ./nix/pkgs/tools/rq { };

            default = pkgs.buildEnv {
              name = "basic-packages";
              paths = [
                dev-packages
                extra-packages
                k8s-packages
                fonts-packages
              ];
            };

            dev-packages = pkgs.buildEnv {
              name = "dev-packages";
              paths = import ./nix/pkgs/dev {
                inherit pkgs;
                fennel-ls = fennel-ls;
              };
            };
            extra-packages = pkgs.buildEnv {
              name = "extra-packages";
              paths = import ./nix/pkgs/extra {
                inherit pkgs system;

                mcp-hub = inputs.mcp-hub;
                mcp-servers-nix = inputs.mcp-servers-nix;

                falco = falco;
                rq = rq;
              };
            };
            k8s-packages = pkgs.buildEnv {
              name = "k8s-packages";
              paths = import ./nix/pkgs/k8s { inherit pkgs; };
            };
            fonts-packages = pkgs.buildEnv {
              name = "fonts-packages";
              paths = import ./nix/pkgs/fonts { inherit pkgs; };
            };
          }
          // (
            if pkgs.stdenv.isLinux then
              {
                lima-img = inputs.nixos-generators.nixosGenerate {
                  inherit pkgs;
                  specialArgs = inputs;
                  modules = [
                    ./nix/hosts/lima/lima.nix
                  ];
                  format = "qcow-efi";
                };
              }
            else
              { }
          );
          pre-commit = {
            check.enable = true;
            settings = {
              hooks = {
                check-merge-conflicts.enable = true;
                check-symlinks.enable = true;
                gitleaks = {
                  enable = true;
                  entry = "${pkgs.gitleaks}/bin/gitleaks protect --staged";
                };
                nixfmt.enable = true;
                treefmt.enable = true;
              };
            };
          };
          devShells.default = pkgs.mkShell {
            inputsFrom = [
              config.pre-commit.devShell
            ];
            packages = with pkgs; [
              ast-grep
              babashka
              gitleaks
              tree-sitter
            ];
            shellHook = ''
              bb build
            '';
          };
          treefmt = {
            programs = {
              actionlint.enable = true;
              nixfmt.enable = true;
              jsonfmt.enable = true;
              yamlfmt.enable = true;
            };
            settings = {
              formatter = {
                ast-grep = {
                  command = "${pkgs.ast-grep}/bin/ast-grep";
                  options = [
                    "scan"
                    "--error"
                  ];
                  includes = [
                    "*.fnl"
                  ];
                };
                jsonfmt.excludes = [
                  "nvim/lazy-lock.json"
                ];
              };
            };
          };
        };
      flake = {
        nixosConfigurations = {
          lima-vm = inputs.nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            specialArgs = inputs;
            modules = [
              ./nix/hosts/lima/lima.nix
            ];
          };
        };
        homeConfigurations = {
          ro-mba2025 =
            let
              system = "aarch64-darwin";
            in
            inputs.home-manager.lib.homeManagerConfiguration {
              pkgs = overlayed-pkgs {
                inherit system;
              };
              modules = [
                ./nix/hosts/common/home.nix
                ./nix/hosts/common/services.nix
                ./nix/hosts/darwin/home.nix
              ];
              extraSpecialArgs = {
                inherit inputs;
                username = "rinx";
                additional-packages = [
                  self.outputs.packages."${system}".dev-packages
                  self.outputs.packages."${system}".extra-packages
                  self.outputs.packages."${system}".k8s-packages
                  self.outputs.packages."${system}".fonts-packages
                ];
              };
            };
          lima =
            let
              system = "aarch64-linux";
            in
            inputs.home-manager.lib.homeManagerConfiguration {
              pkgs = overlayed-pkgs {
                inherit system;
              };
              modules = [
                ./nix/hosts/common/home.nix
                ./nix/hosts/common/services.nix
                ./nix/hosts/lima/home.nix
                ./nix/hosts/lima/services.nix
              ];
              extraSpecialArgs = {
                inherit inputs;
                username = "rinx";
                additional-packages = [
                  self.outputs.packages."${system}".dev-packages
                ];
              };
            };
        };
        nixOnDroidConfigurations = {
          bigme-b7 =
            let
              system = "aarch64-linux";
            in
            inputs.nix-on-droid.lib.nixOnDroidConfiguration {
              pkgs = import inputs.nixpkgs-droid {
                inherit system;
              };
              modules = [
                ./nix/hosts/droid/nix-on-droid.nix
              ];
              extraSpecialArgs = {
                pkgs-unstable = import inputs.nixpkgs-unstable-droid {
                  inherit system;
                  config.allowUnfree = true;
                  overlays = [
                    inputs.neovim-nightly.overlays.default
                  ];
                };
              };
            };
        };
        nixosModules = {
          lima-docker-fix = {
            imports = [ ./nix/hosts/lima/docker-fix.nix ];
          };
        };
      };
    };
}
