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

  nativeBuildInputs = with pkgs; [
    hy
  ];

  buildInputs = with pkgs; [
    duckdb
    pandoc
    (python3.withPackages (python-pkgs: with python-pkgs; [
      duckdb
      hy
      hyrule
      langchain
      langchain-community
      pypandoc
      sentence-transformers
      sentencepiece
      torch
      transformers
      unstructured
    ]))
  ];

  buildPhase = ''
    runHook preBuild

    echo "#!/usr/bin/env python" > index.py
    hy2py index.hy >> index.py
    echo "#!/usr/bin/env python" > search.py
    hy2py search.hy >> search.py

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -D ./index.py $out/bin/org-search-utils-index
    install -D ./search.py $out/bin/org-search-utils-search

    runHook postInstall
  '';
}
