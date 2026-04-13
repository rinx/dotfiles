{
  lib,
  buildGoModule,
  fetchFromSourcehut,
}:
buildGoModule rec {
  pname = "rq";
  version = "873843db7b6010218bcfecd799a4c6690e862c16";

  src = fetchFromSourcehut {
    owner = "~charles";
    repo = "rq";
    rev = "${version}";
    hash = "sha256-4koKuZiCboupoTTFbFc/5EO+08RBPow2T+iTOLZyyTc=";
  };

  vendorHash = "sha256-OprZ8ktHLUwN/TibY8FfMJXvScw8G1A2VgtZ+lrHmIo=";
}
