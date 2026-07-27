{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.3.4-3";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-k1iXWdwfPx5eFIYVBdgrxl2/2WqQYCEwl7VjqGFyqOg=";
  };

  vendorHash = "sha256-EAsp01vgsCiP6PHNUPB3xqKBELQhQgRBmS28aW+y+0Q=";
}
