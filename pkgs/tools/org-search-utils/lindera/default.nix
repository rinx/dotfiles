{
  lib,
  buildPythonPackage,
  fetchPypi,
  rustPlatform,
  setuptools,
  wheel,
  pip,
  rustc,
  cargo,
}:
buildPythonPackage rec {
  pname = "lindera_py";
  version = "0.42.2";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-jhWWQfmNh03rvI+b/d63VF0bQYHPzkppPu+yvEaNUD4=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-6M1M6AGhPFpsXWg/AOPw84kuY5BCA/HPThdsMmHNV3w=";
  };

  format = "pyproject";

  maturinBuildFlags = "--features=ipadic";

  nativeBuildInputs = [
    setuptools
    wheel
    pip
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    rustc
    cargo
  ];

  pythonImportsCheck = [ "lindera_py" ];
}
