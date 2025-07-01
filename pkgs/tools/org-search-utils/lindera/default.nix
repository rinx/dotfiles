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
  pname = "lindera_py";
  version = "0.44.0";

  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    dist = "cp312";
    python = "cp312";
    abi = "cp312";
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
          "sha256-EFZfdNkgVqdDy4O0hdSCol8xwhviLbHaloY13k5cF1c="
        else
          "sha256-KX/S7hXWFvz2uv4N/8oyY4lSAI2xuGy/rHvGMhmnwuw="
      else if stdenv.isLinux then
        if stdenv.isAarch64 then
          "sha256-S4DfTytfzI7S0x5hM1cqqEzkKgSGYUlwuCRj5PDDWg8="
        else
          "sha256-BtCqeKoZoVNIYx82G8iCpoQ1E6qhVTApiW87zbElVz8="
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

  pythonImportsCheck = [ "lindera_py" ];
}
