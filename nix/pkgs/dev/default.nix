{
  pkgs,
  ...
}@inputs:
let
  aws-sts-token = pkgs.callPackage ../tools/aws-sts-token { };

  gctx = pkgs.callPackage ../tools/gctx { };

  git-switcher = pkgs.callPackage ../tools/git-switcher { };

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

  open-policy-agent = pkgs.open-policy-agent.overrideAttrs {
    doCheck = false;
  };

  custom-pkgs = [
    aws-sts-token
    gctx
    git-switcher
    google-cloud-sdk-with-components
    inputs.fennel-ls
    open-policy-agent
  ];
in
with pkgs;
[
  ## tools
  bat
  cmakeMinimal
  conftest
  cue
  curl
  delta
  direnv
  duckdb
  eza
  fd
  fzf
  gh
  ghq
  git
  gnumake
  imagemagick
  jq
  lazygit
  neovim-unwrapped
  nix-direnv
  # open-policy-agent
  pass
  passExtensions.pass-otp
  ripgrep
  sad
  tree-sitter
  wget
  yq-go
  zsh

  ## cloud development
  awscli2
  tenv

  ## languages
  babashka
  clojure
  deno
  gcc
  gleam
  go
  nodejs

  ## LSP / DAP / Linter / Formatter
  actionlint
  bash-language-server
  clj-kondo
  clojure-lsp
  copilot-language-server
  cuelsp
  delve
  docker-compose-language-service
  dockerfile-language-server
  efm-langserver
  gitlint
  gopls
  hadolint
  nil
  nixd
  regal
  shellcheck
  shfmt
  terraform-ls
  tflint
  vscode-langservers-extracted
  yaml-language-server
  zizmor
]
++ custom-pkgs
