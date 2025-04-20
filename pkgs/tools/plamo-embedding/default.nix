{ lib, python3Packages }:
with python3Packages;
buildPythonApplication {
  pname = "plamo-embedding";
  version = "1.0";

  propagatedBuildInputs = [
    sentencepiece
    torch
    transformers
  ];

  src = ./.;
}
