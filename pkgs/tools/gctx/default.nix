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

  buildInputs = with pkgs; [
    babashka
    fzf
    google-cloud-sdk
  ];

  installPhase = ''
    runHook preInstall

    install -D gctx.clj $out/bin/gctx

    runHook postInstall
  '';
}
