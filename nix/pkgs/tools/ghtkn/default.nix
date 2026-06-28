{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.3.1-0";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-hBiDUIO8ra6xYabeyJhHSeEVD5uu9RsfavrzT3gEVaI=";
  };

  vendorHash = "sha256-mUZcPYyeHRKgDoWJMTyYDhkH39iqSw1/qTwNEjMv+oE=";
}
