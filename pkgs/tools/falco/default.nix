{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "falco";
  version = "1.21.1";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-Ni2MWS/oOfQCvFclyi79DRzFc5Z8/8Q4/nL8T/jWmVg=";
  };

  vendorHash = "sha256-pCkbDAvbBXzs5TViUT9QMlbiGFPadXZi4cphW6F4ZfA=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
