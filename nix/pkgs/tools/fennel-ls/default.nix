{
  lib,
  stdenv,
  lua,
  luaPackages,
  pandoc,
  fetchFromSourcehut,
}:
stdenv.mkDerivation (finalAttrs: rec {
  pname = "fennel-ls";
  version = "0.2.4";

  src = fetchFromSourcehut {
    owner = "~xerool";
    repo = "fennel-ls";
    rev = "${version}";
    hash = "sha256-RIkwL/nF0LwQZOXlUidyQVfRWuFBO5TobNTZrUFuJ64=";
  };

  nativeBuildInputs = [
    pandoc
  ];

  buildInputs = [
    lua
    luaPackages.fennel
  ];

  makeFlags = [ "PREFIX=$(out)" ];
  installFlags = [ "PREFIX=$(out)" ];
})
