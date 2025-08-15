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
    dist = "cp313";
    python = "cp313";
    abi = "cp313";
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
          "sha256-7EBn7JKxes2IN0L7WQlHv0PBa4VSQLYVP6AMb+aKXOo="
        else
          "sha256-DxuQe36utYXv5jqBZoQP2idKHnfnUs4YyC5Rs/SD5wQ="
      else if stdenv.isLinux then
        if stdenv.isAarch64 then
          "sha256-sj4OA8YAica9j/WXsTeeib9SyY2lzsrJA8wscVUXlRc="
        else
          "sha256-Gi5JKpgisKzmxmfO99U1r+1uH1dtTnEqRGJs/P72BVg="
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
