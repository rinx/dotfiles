{
  pkgs,
  system,
  ...
}@inputs:
let
  org-search-utils = pkgs.callPackage ../tools/org-search-utils { };

  custom-pkgs = [
    inputs.falco
    inputs.rq
    org-search-utils
  ];

  os-specific-pkgs =
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
++ os-specific-pkgs
