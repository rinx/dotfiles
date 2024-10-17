{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "falco";
  version = "1.10.0";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-x5d/SOFYrMBnMg6TV3hwmtTtcEMPZG6lEHFOTesjFfQ=";
  };

  vendorHash = "sha256-5ntJ3MdPiFOBmHrwht485LnSReljokDVPx3yT1p1mxY=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
