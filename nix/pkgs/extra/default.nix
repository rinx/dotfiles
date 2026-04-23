{
  pkgs,
  ...
}@inputs:
let
  google-cloud-sdk-with-components =
    with pkgs.google-cloud-sdk;
    withExtraComponents (
      with components;
      [
        beta
        bq
        core
        gcloud-crc32c
        gsutil
        gke-gcloud-auth-plugin
      ]
    );

  org-search-utils = pkgs.callPackage ../tools/org-search-utils { };

  custom-pkgs = [
    google-cloud-sdk-with-components
    inputs.fennel-ls
    inputs.rq
    org-search-utils
  ];

  os-specific-pkgs =
    if pkgs.stdenv.isDarwin then
      [
        pkgs.pngpaste
      ]
    else
      [
        pkgs.chromium
      ];
in
with pkgs;
[
  ## tools
  awscli2
  conftest
  cue
  duckdb
  lazygit
  mcat
  pandoc
  pass
  passExtensions.pass-otp

  ## languages
  buf
  protobuf
  typescript-go
  typst

  ## LSP / DAP / Linter / Formatter
  clj-kondo
  clojure-lsp
  copilot-language-server
  cuelsp
  delve
  gopls
  harper
  marksman
  regal
  tinymist
  zizmor
]
++ custom-pkgs
++ os-specific-pkgs
