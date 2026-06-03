{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.2.5-1";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-kqJHnG7JDNfsnx2L/RaN6f+U+LW8q6y/6+Wy+nWoPPo=";
  };

  vendorHash = "sha256-MvziGBc12YacYZ3zBxQY7l/WdBe7FvR0d4im6rzlFXI=";
}
