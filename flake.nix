{
  description = "A flake that installs basic development tools.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      mcp-hub,
      mcp-servers-nix,
      neovim-nightly,
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
            overlays = [
              neovim-nightly.overlays.default
            ];
          };
        in
        {
          default = import ./pkgs {
            inherit self;
            inherit pkgs;
            inherit mcp-hub;
            inherit mcp-servers-nix;
            flake-inputs = inputs;
            system = system;
          };
        }
      );
      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
        aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixfmt-rfc-style;
        x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixfmt-rfc-style;
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
      };
    };
}
