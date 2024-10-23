{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "falco";
  version = "1.11.2";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-2jmzdjahOB/iEF5AzusA5PMDT1O1JKhpiirnSRN2j3Q=";
  };

  vendorHash = "sha256-ReWwkJJqOiS9l6E47ulE+T7jxYnzvxPQiqGQw3+P9No=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
