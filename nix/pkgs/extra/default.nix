{
  pkgs,
  system,
  ...
}@inputs:
let
  org-search-utils = pkgs.callPackage ../tools/org-search-utils { };

  osc52-copy = pkgs.callPackage ../tools/osc52-copy { };

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

  os-specific-pkgs =
    if pkgs.stdenv.isDarwin then
      [
        pkgs.pngpaste
      ]
    else
      [
        osc52-copy
      ];
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
++ os-specific-pkgs
