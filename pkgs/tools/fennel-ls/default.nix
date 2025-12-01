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
  version = "0.2.3";

  src = fetchFromSourcehut {
    owner = "~xerool";
    repo = "fennel-ls";
    rev = "${version}";
    hash = "sha256-BU0SkdBjq8kicvACIo3N2gf1UvTmzA3FKSt39Lxp3rs=";
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
