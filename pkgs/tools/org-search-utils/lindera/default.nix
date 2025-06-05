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
  version = "0.43.1";

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
          "sha256-Jdu8wlKKT+HLD+VIHULNdV3j+c7Vt0iRiEHMm6El6R0="
        else
          "sha256-2c3MNvxJ50Z5o7KXLJj11yP7eu/Qbl+g5LPjXUsV3SM="
      else if stdenv.isLinux then
        if stdenv.isAarch64 then
          "sha256-4wCmmypBYC129aOCtAvsXhDJ9PjjbxDzx1P8IfKXAec="
        else
          "sha256-chQmjAO0r8jbx4vA233HW7Z+ukiRyATOaloIV/qG1bU="
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
