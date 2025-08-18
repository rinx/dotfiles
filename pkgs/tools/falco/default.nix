{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "falco";
  version = "1.19.0";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-KMRcqHavx9WWg0Xe+nyVDQstWVNaUcMhPrMHimF7up4=";
  };

  vendorHash = "sha256-5Kt5HHIbXmcwzTUVCxvDv8lWZgligFMOlow/rhO0FZE=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
