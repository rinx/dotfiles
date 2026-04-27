{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-Du8hf4twpWtAPe81SR+xO03a52YWj+AJFI2E/gReptw=";
  };

  vendorHash = "sha256-3teRNjOOQQEJzAkXhoiV9VpYQ4EdAMBIwAyVgkMzJCY=";
}
