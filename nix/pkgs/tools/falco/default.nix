{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "falco";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "ysugimoto";
    repo = "falco";
    rev = "v${version}";
    hash = "sha256-He3+TEELF998GshImkdFpkqQ9kTzz1WIbKOSwCowqq4=";
  };

  vendorHash = "sha256-GQktsSmEZac7DxlPjlUbzYE/rDik71sHUejQHOKlDbI=";

  ldflags = [
    "-X main.version=${version}"
  ];
}
