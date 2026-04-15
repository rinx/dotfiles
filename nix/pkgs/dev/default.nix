{
  pkgs,
  ...
}@inputs:
let
  aws-sts-token = pkgs.callPackage ../tools/aws-sts-token { };

  gctx = pkgs.callPackage ../tools/gctx { };

  git-switcher = pkgs.callPackage ../tools/git-switcher { };

  open-policy-agent = pkgs.open-policy-agent.overrideAttrs {
    doCheck = false;
  };

  osc52-copy = pkgs.callPackage ../tools/osc52-copy { };
  custom-pkgs = [
    aws-sts-token
    gctx
    git-switcher
    open-policy-agent
  ];

  os-specific-pkgs =
    if pkgs.stdenv.isDarwin then
      [ ]
    else
      [
        osc52-copy
      ];
in
with pkgs;
[
  ## tools
  ast-grep
  bat
  cmakeMinimal
  curl
  delta
  direnv
  eza
  fd
  fzf
  gh
  ghq
  git
  gnumake
  gnupg
  imagemagick
  jq
  neovim-unwrapped
  nix-direnv
  # open-policy-agent
  ripgrep
  sad
  tenv
  tree-sitter
  wget
  yq-go
  zsh

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
  docker-compose-language-service
  dockerfile-language-server
  efm-langserver
  gitlint
  hadolint
  nil
  nixd
  shellcheck
  shfmt
  terraform-ls
  tflint
  vscode-langservers-extracted
  yaml-language-server
]
++ custom-pkgs
++ os-specific-pkgs
