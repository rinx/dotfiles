{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "regal";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "StyraInc";
    repo = "regal";
    rev = "v${version}";
    hash = "sha256-YVVAOMIHGXzByS47ElY2t81kZuFnjLmjT9EibLn8/ac=";
  };

  vendorHash = "sha256-nh0ucEVKnhPNY/z1Ax2Juq3i4E9PrT7WloDfnbxPUOI=";
}
