{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  name = "gctx";
  version = "0.1.0";

  src = ./.;

  dontConfigure = true;

  buildInputs = [
    pkgs.babashka
  ];

  installPhase = ''
    runHook preInstall

    install -D gctx $out/bin/gctx

    runHook postInstall
  '';
}
