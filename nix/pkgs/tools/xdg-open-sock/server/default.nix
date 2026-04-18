{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  name = "xdg-open-sock";
  version = "0.1.0";

  src = ./.;

  dontConfigure = true;

  nativeBuildInputs = with pkgs; [
    gleam
    beamMinimalPackages.erlang
    beamMinimalPackages.rebar3
  ];

  buildInputs = with pkgs; [
    gleam
    beamMinimalPackages.erlang
    beamMinimalPackages.rebar3
  ];

  buildPhase = ''
    runHook preBuild

    gleam build
    gleam export erlang-shipment

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    runHook postInstall
  '';
}
