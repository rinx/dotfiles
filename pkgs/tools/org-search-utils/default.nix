{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  name = "org-search-utils";
  version = "0.1.0";

  src = ./.;

  dontConfigure = true;

  buildInputs = with pkgs; [
    pandoc
    (python3.withPackages (python-pkgs: with python-pkgs; [
      duckdb
      hy
      hyrule
      langchain
      langchain-community
      pypandoc
      sentencepiece
      torch
      transformers
      unstructured
    ]))
  ];

  installPhase = ''
    runHook preInstall

    install -D index.hy $out/bin/org-search-utils-index
    install -D search.hy $out/bin/org-search-utils-search

    runHook postInstall
  '';
}
