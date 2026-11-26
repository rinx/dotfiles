{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "4.0.1-0";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-rHpO7+4yN9RM87FF41OzwyVswYJ3dEYWb9wfj537AoY=";
  };

  vendorHash = "sha256-01aumTd6UjZyfjP9lxNSuT9Cd600o1cmcqM31UwB0vw=";
}
