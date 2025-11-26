{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "falco";
  version = "1.21.0";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-x+g1NI1SZvQ7cmnD275y7QgG/3y806sHO7jZWjOqRZc=";
  };

  vendorHash = "sha256-pCkbDAvbBXzs5TViUT9QMlbiGFPadXZi4cphW6F4ZfA=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
