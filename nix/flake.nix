{
  description = "A flake that installs basic development tools.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{
    self,
    nixpkgs,
  }: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "x86_64-darwin"
      # "aarch64-darwin"
    ];
  in rec {
    packages = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
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
