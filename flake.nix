{
  description = "A flake that installs basic development tools.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";

    # non-flake packages
    ysugimoto-falco = {
      url = "github:ysugimoto/falco";
      flake = false;
    };
    charles-rq = {
      url = "git+https://git.sr.ht/~charles/rq";
      flake = false;
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
          packages.default = import ./pkgs {
            inherit self pkgs system;
            mcp-hub = inputs.mcp-hub;
            mcp-servers-nix = inputs.mcp-servers-nix;
            ysugimoto-falco = inputs.ysugimoto-falco;
            charles-rq = inputs.charles-rq;
          };
          formatter = pkgs.nixfmt-rfc-style;
          pre-commit = {
            check.enable = true;
            settings = {
              hooks = {
                nixfmt-rfc-style.enable = true;
              };
            };
          };
          devShells.default = pkgs.mkShell {
            inputsFrom = [
              config.pre-commit.devShell
            ];
            packages = [ ];
          };
        };
    };
}
