{
  description = "A flake that installs basic development tools.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    neovim-nightly,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "x86_64-darwin"
      # "aarch64-darwin"
    ];
  in {
    packages = forAllSystems (system:
      let
        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true;
          overlays = [
            neovim-nightly.overlay
          ];
        };
      in {
        default = import ./pkgs {
          inherit self;
          inherit pkgs;
          flake-inputs = inputs;
        };
      }
    );
  };
}
