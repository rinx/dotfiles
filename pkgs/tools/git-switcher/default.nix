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

  buildInputs = with pkgs; [
    babashka
    fzf
    git
  ];

  installPhase = ''
    runHook preInstall

    install -D git-switcher $out/bin/git-switcher

    runHook postInstall
  '';
}
