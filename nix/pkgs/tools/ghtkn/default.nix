{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-iQv4fls8sx8IDxxmfebbDHGala+cXyv9RGLL2p3al5I=";
  };

  vendorHash = "sha256-rsTESgnUFTRXLOyX2Q/5QQFSnoANJELITI8btISWn7o=";
}
