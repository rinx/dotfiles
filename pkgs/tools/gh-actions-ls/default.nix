{
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
}:
let
  name = "gh-actions-language-server";
  version = "20250111";

  src = fetchFromGitHub {
    owner = "lttb";
    repo = "gh-actions-language-server";
    rev = "0287d3081d7b74fef88824ca3bd6e9a44323a54d";
    hash = "sha256-ZWO5G33FXGO57Zca5B5i8zaE8eFbBCrEtmwwR3m1Px4=";
  };

  # NOTE: use bun-baseline because the normal bun cannot run on non-avx machines
  # See https://github.com/NixOS/nixpkgs/pull/313760
  bunBaseline =
    let
      bunVersion = "1.2.4";
    in
    pkgs.bun.overrideAttrs rec {
      version = bunVersion;
      passthru.sources = {
        # NOTE: use bun-baseline version only for x86 linux
        "x86_64-linux" = pkgs.fetchurl {
          url = "https://github.com/oven-sh/bun/releases/download/bun-v${bunVersion}/bun-linux-x64-baseline.zip";
          hash = "sha256-4D6yVZphrwz7es8+WSctVWE+8UB48Vb3siUSRWyqD4s=";
        };
        "x86_64-darwin" = pkgs.fetchurl {
          url = "https://github.com/oven-sh/bun/releases/download/bun-v${bunVersion}/bun-darwin-x64.zip";
          hash = "sha256-0qTvLK5/N8FkFeenZopuhMFdiLnOj/wfu0T0P3fTC8k=";
        };
        "aarch64-darwin" = pkgs.fetchurl {
          url = "https://github.com/oven-sh/bun/releases/download/bun-v${bunVersion}/bun-darwin-aarch64.zip";
          hash = "sha256-/UcChwu7kRg2RppwOu58HH26/HzY/FgEKbot2hi7WqE=";
        };
        "aarch64-linux" = pkgs.fetchurl {
          url = "https://github.com/oven-sh/bun/releases/download/bun-v${bunVersion}/bun-linux-aarch64.zip";
          hash = "sha256-vqL/H5t0elgT9fSk0Op7Td69eP9WPY2XVo1a8sraTwM=";
        };
      };
      src = passthru.sources.${pkgs.system};
    };

  node_modules = stdenv.mkDerivation {
    inherit src version;

    pname = "${name}-node_modules";
    impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ [
      "GIT_PROXY_COMMAND"
      "SOCKS_SERVER"
    ];
    nativeBuildInputs = [
      bunBaseline
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
    outputHash =
      if stdenv.isLinux then
        "sha256-HfMP9OI07CpiOQw5xkpcRPKPv/MflU1FjtSMOuCkYtg="
      else
        "sha256-d8u+crJ6B1vI3141QAqcuFLXRPzzMRUr3KrO0hTdPrg=";
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };
in
stdenv.mkDerivation {
  inherit name;
  inherit version;
  inherit src;

  nativeBuildInputs = [
    bunBaseline
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
    cp -R ./node_modules $out/node_modules

    runHook postInstall
  '';
}
