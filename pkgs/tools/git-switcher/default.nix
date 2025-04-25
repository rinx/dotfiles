{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  name = "git-switcher";
  version = "0.1.0";

  src = ./.;

  dontConfigure = true;

  buildInputs = [
    pkgs.babashka
  ];

  installPhase = ''
    runHook preInstall

    install -D git-switcher $out/bin/git-switcher

    runHook postInstall
  '';
}
