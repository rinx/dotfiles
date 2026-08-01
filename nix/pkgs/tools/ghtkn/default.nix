{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.3.5";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-0Cg5VaQ6u1G6BXLYo7oqTRU4PMd5NU5l5EQZdI9mBY0=";
  };

  vendorHash = "sha256-cBpTQu5yO9p+UvIrAEVxRMddwbX5ay4zVNShfmullyg=";
}
