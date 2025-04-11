{
  description = "A flake that installs basic development tools.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      systems,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      perSystem =
        {
          config,
          self',
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
            flake-inputs = inputs;
          };
          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
