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
  version = "0.45.0";

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
          "sha256-nXETwzXKdAKRXPAk4Ynzwb63qW8cp/+mKOvipNolI0Y="
        else
          "sha256-0WtinvWaK+c2N6Dg2xwmN630Zqp53AUqLfXaREzPjhs="
      else if stdenv.isLinux then
        if stdenv.isAarch64 then
          "sha256-48xUuQwZQiloMv0EwhR7spCwH6LTVKgnBOCvjZbD1DE="
        else
          "sha256-ZQeUvDixPJy7Ae/TmNI+RWWO8UiMiW/BvMsNyubh/ow="
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
