{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "falco";
  version = "1.20.0";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-XNJyV9unLyNIUS59le6YpigiHnlCAyTHxuc8RMBKkts=";
  };

  vendorHash = "sha256-5Kt5HHIbXmcwzTUVCxvDv8lWZgligFMOlow/rhO0FZE=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
