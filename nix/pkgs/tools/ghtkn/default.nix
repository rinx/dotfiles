{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-H1dyBbwq3jVftk/90f6iDrwiTTwvnGYOWALATrLsBHc=";
  };

  vendorHash = "sha256-7mw8SPjs6HCQVx62yoKugSf1J/rqsG9uBfVCfsVWpnY=";
}
