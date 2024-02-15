{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "regal";
  version = "0.16.0";

  src = fetchFromGitHub {
    owner = "StyraInc";
    repo = "regal";
    rev = "v${version}";
    hash = "sha256-VjxoqLpbCq5+bZIk9qwRkEOCHizvvotXKdIzpn8ydbU=";
  };

  vendorHash = "sha256-DMcyB6l2bNKG0W6fz6FqAeQVdFETgxOQYtxMArz0cv0=";
}
