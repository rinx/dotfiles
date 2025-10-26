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
  version = "0.2.2";

  src = fetchFromSourcehut {
    owner = "~xerool";
    repo = "fennel-ls";
    rev = "${version}";
    hash = "sha256-N1530u8Kq7ljdEdTFk0CJJyMLMVX5huQWXjyoMBJN5E=";
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
