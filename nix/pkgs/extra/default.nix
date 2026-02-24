{
  pkgs,
  system,
  ...
}@inputs:
let
  org-search-utils = pkgs.callPackage ../tools/org-search-utils { };

  mcp-servers = pkgs.callPackage ../settings/mcp-servers {
    mcp-servers-nix = inputs.mcp-servers-nix;
  };

  custom-pkgs = [
    inputs.falco
    inputs.mcp-hub.packages."${system}".default
    inputs.rq
    mcp-servers
    org-search-utils
  ];

  darwin-pkgs =
    if pkgs.stdenv.isDarwin then
      [
        pkgs.pngpaste
      ]
    else
      [ ];
in
with pkgs;
[
  ## tools
  ast-grep
  pandoc

  ## languages
  buf
  protobuf
  typescript-go
  typst

  ## LSP / DAP / Linter / Formatter
  harper
  marksman
  tinymist
]
++ custom-pkgs
++ darwin-pkgs
