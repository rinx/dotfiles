{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "regols";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "kitagry";
    repo = "regols";
    rev = "v${version}";
    hash = lib.fakeHash;
  };

  vendorHash = lib.fakeHash;
}
