{
  description = "A flake that installs basic development tools.";

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
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              inputs.neovim-nightly.overlays.default
            ];
          };
          packages = rec {
            rq = pkgs.callPackage ./pkgs/tools/rq { };
            fennel-ls = pkgs.callPackage ./pkgs/tools/fennel-ls { };
            falco = pkgs.callPackage ./pkgs/tools/falco { };

            default = import ./pkgs {
              inherit self pkgs system;

              mcp-hub = inputs.mcp-hub;
              mcp-servers-nix = inputs.mcp-servers-nix;

              falco = falco;
              fennel-ls = fennel-ls;
              rq = rq;
            };
          };
          pre-commit = {
            check.enable = true;
            settings = {
              hooks = {
                nixfmt-rfc-style.enable = true;
                treefmt.enable = true;
              };
            };
          };
          devShells.default = pkgs.mkShell {
            inputsFrom = [
              config.pre-commit.devShell
            ];
            packages = [
              pkgs.babashka
              pkgs.tree-sitter
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
              zizmor.enable = true;
            };
            settings = {
              formatter = {
                jsonfmt.excludes = [
                  "nvim/lazy-lock.json"
                ];
              };
            };
          };
        };
    };
}
