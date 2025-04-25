{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  name = "aws-sts-token";
  version = "0.1.0";

  src = ./.;

  dontConfigure = true;

  buildInputs = [
    pkgs.babashka
  ];

  installPhase = ''
    runHook preInstall

    install -D aws-sts-token $out/bin/aws-sts-token

    runHook postInstall
  '';
}
