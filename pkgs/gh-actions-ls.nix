{
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
}: let
  name = "gh-actions-language-server";
  version = "20250111";

  src = fetchFromGitHub {
    owner = "lttb";
    repo = "gh-actions-language-server";
    rev = "0287d3081d7b74fef88824ca3bd6e9a44323a54d";
    hash = "sha256-ZWO5G33FXGO57Zca5B5i8zaE8eFbBCrEtmwwR3m1Px4=";
  };
  node_modules = stdenv.mkDerivation {
    inherit src version;

    pname = "${name}-node_modules";
    impureEnvVars = lib.fetchers.proxyImpureEnvVars
      ++ [ "GIT_PROXY_COMMAND" "SOCKS_SERVER" ];
    nativeBuildInputs = [
      pkgs.bun
    ];
    dontConfigure = true;
    buildPhase = ''
      bun install --no-progress --frozen-lockfile
    '';
    installPhase = ''
      mkdir -p $out/node_modules

      cp -R ./node_modules/* $out/node_modules
      ls -la $out/node_modules
    '';
    dontFixup = true;
    dontPatchShebangs = true;
    outputHash = if stdenv.isLinux then
      "sha256-HfMP9OI07CpiOQw5xkpcRPKPv/MflU1FjtSMOuCkYtg="
    else
      "sha256-d8u+crJ6B1vI3141QAqcuFLXRPzzMRUr3KrO0hTdPrg=";
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };
in stdenv.mkDerivation {
  inherit name;
  inherit version;
  inherit src;

  nativeBuildInputs = [
    pkgs.bun
  ];

  buildInputs = [
    pkgs.nodejs
  ];

  dontConfigure = true;

  buildPhase = ''
    runHook preBuild

    ln -s ${node_modules}/node_modules ./
    npm run build:node

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -D ./bin/gh-actions-language-server $out/bin/gh-actions-language-server

    runHook postInstall
  '';
}
