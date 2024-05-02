{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation rec {
  name = "moralerspace-nerd-font";
  version = "1.0.0";

  src = fetchzip {
    url = "https://github.com/yuru7/moralerspace/releases/download/v${version}/MoralerspaceNF_v${version}.zip";
    hash = "sha256-8ceIA+OkDqFksqF1TlcGHTGMulaf0ZY2N59hEbb8jaY=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/moralerspace-nerdfont/ *.ttf

    runHook postInstall
  '';
}
