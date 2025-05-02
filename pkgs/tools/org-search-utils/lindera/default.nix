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
  version = "0.42.2";

  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    dist = "cp312";
    python = "cp312";
    abi = "cp312";
    platform = if stdenv.isDarwin then
      if stdenv.isAarch64 then "macosx_11_0_arm64"
      else "macosx_10_12_x86_64"
    else if stdenv.isLinux then
      if stdenv.isAarch64 then "manylinux_2_17_x86_64.manylinux2014_aarch64"
      else "manylinux_2_17_x86_64.manylinux2014_x86_64"
    else throw "Unsupported platform";
    sha256 = if stdenv.isDarwin then
      if stdenv.isAarch64 then "sha256-Eji52U0h0wB3us1gkuEY+SdRNx0YXNF6x06s6M3AkgU="
      else "sha256-scKDF1cS7EWPr+zqSN8fblE3qxsxYuch8iFbpeLKP6E="
    else if stdenv.isLinux then
      if stdenv.isAarch64 then "sha256-dpU8Ri2sZGflukLW4G0igWJP2APhcMxwrB73uZ4dTv8="
      else "sha256-U5W3hRlhbTQIcMNfUg4smEnsfgvcNEtepks2akGQiJw="
    else throw "Unsupported platform";
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
