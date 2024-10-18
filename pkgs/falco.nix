{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "falco";
  version = "1.11.1";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-zOLMlqhAyplDkMmg1I4s3WulwUENcNMpH3utJKH9xH0=";
  };

  vendorHash = "sha256-ReWwkJJqOiS9l6E47ulE+T7jxYnzvxPQiqGQw3+P9No=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
