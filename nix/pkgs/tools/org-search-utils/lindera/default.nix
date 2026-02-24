{
  lib,
  stdenv,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  pip,
  openssl,
}:
buildPythonPackage rec {
  pname = "lindera_python_ipadic";
  version = "2.0.0";

  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    dist = "cp310";
    python = "cp310";
    abi = "abi3";
    platform =
      if stdenv.isDarwin then
        if stdenv.isAarch64 then "macosx_11_0_arm64" else "macosx_10_12_x86_64"
      else if stdenv.isLinux then
        if stdenv.isAarch64 then
          "manylinux_2_17_aarch64.manylinux2014_aarch64"
        else
          "manylinux_2_17_x86_64.manylinux2014_x86_64"
      else
        throw "Unsupported platform";
    sha256 =
      if stdenv.isDarwin then
        if stdenv.isAarch64 then
          "sha256-1uNWk0xjs8VKy8l+l3Qs9sp8xORU2aixStcuehj8yrU="
        else
          "sha256-/22b5UNbpZ3hLDZYKRBmthlwIYbdC5Aw1N4x+nwUHwE="
      else if stdenv.isLinux then
        if stdenv.isAarch64 then
          "sha256-qavMxmu7b476AXJJxGyh0ShZbOcHtTIhUi6fexSHki4="
        else
          "sha256-S/NXXcSuIWDnTFtMr/yqjeNO8Jir4ZPoi2FR3yEWMoo="
      else
        throw "Unsupported platform";
  };

  format = "wheel";

  nativeBuildInputs = [
    setuptools
    wheel
    pip
  ];

  buildInputs = [
    openssl
  ];

  pythonImportsCheck = [ "lindera" ];
}
