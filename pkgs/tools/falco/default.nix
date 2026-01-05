{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "falco";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-MhXNkS4JGbj3Fd1gfmO/EJX0hCwzNQYy9cAOMCfH0sI=";
  };

  vendorHash = "sha256-pCkbDAvbBXzs5TViUT9QMlbiGFPadXZi4cphW6F4ZfA=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
