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

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
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

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs = {
        flake-parts.follows = "flake-parts";
      };
    };
    claude-code = {
      url = "github:sadjow/claude-code-nix";
    };

    agent-skills = {
      url = "github:Kyure-A/agent-skills-nix";
    };

    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };

    ast-grep-skill = {
      url = "github:ast-grep/agent-skill";
      flake = false;
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://rinx.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "rinx.cachix.org-1:dnKhEzrRDhJmzOKhwwjKc9FsGvY9Bq2MddbtPd8Qsmc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
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
              };
            };
            extra-packages = pkgs.buildEnv {
              name = "extra-packages";
              paths = import ./nix/pkgs/extra {
                inherit pkgs system;

                falco = falco;
                fennel-ls = fennel-ls;
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
          devShells.default =
            let
              sgconfig = (pkgs.formats.yaml { }).generate "sgconfig.yml" {
                ruleDirs = [ "./.config/rules" ];
                testConfigs = [
                  {
                    testDir = "./.config/rule-tests";
                  }
                ];
                customLanguages = {
                  fennel = {
                    libraryPath = "${pkgs.vimPlugins.nvim-treesitter-parsers.fennel}/parser/fennel.so";
                    extensions = [ "fnl" ];
                  };
                };
              };
            in
            pkgs.mkShell {
              inputsFrom = [
                config.pre-commit.devShell
              ];
              packages = with pkgs; [
                ast-grep
                gitleaks
                tree-sitter
              ];
              shellHook = ''
                ln -sf ${sgconfig} sgconfig.yml
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
          sandbox-vm = inputs.nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            specialArgs = inputs;
            modules = [
              ./nix/hosts/lima/lima.nix
              ./nix/hosts/lima/sandbox.nix
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
                ./nix/hosts/common/agents.nix
                ./nix/hosts/darwin/home.nix
                inputs.nix-index-database.homeModules.default
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

                agent-skills = inputs.agent-skills;
                anthropic-skills = inputs.anthropic-skills;
                ast-grep-skill = inputs.ast-grep-skill;
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
                ./nix/hosts/common/agents.nix
                ./nix/hosts/lima/home.nix
                ./nix/hosts/lima/services.nix
                inputs.nix-index-database.homeModules.default
              ];
              extraSpecialArgs = {
                inherit inputs;

                username = "rinx";
                additional-packages = [
                  self.outputs.packages."${system}".dev-packages
                ];

                agent-skills = inputs.agent-skills;
                anthropic-skills = inputs.anthropic-skills;
                ast-grep-skill = inputs.ast-grep-skill;
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
