{
  lib,
  stdenv,
  source,
  lua,
  luaPackages,
  pandoc,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "fennel-ls";
  version = "0.2.0";

  src = source;

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
