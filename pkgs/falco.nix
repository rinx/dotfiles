{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "falco";
  version = "1.11.0-rc";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    # rev = "v${version}";
    rev = "81173491f14ea74685ae1e131c5d8660929d5662";
    hash = "sha256-4MRLTt4HT9yW9HiyLIWBIMVmavWAGfsN6/DypkhLdq8=";
  };

  vendorHash = "sha256-ReWwkJJqOiS9l6E47ulE+T7jxYnzvxPQiqGQw3+P9No=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
