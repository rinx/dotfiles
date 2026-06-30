{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-Tcw/JL5U0af6Bf8b2jV5ElhCSMrhGjHfVF1ZqCXnUR4=";
  };

  vendorHash = "sha256-rsTESgnUFTRXLOyX2Q/5QQFSnoANJELITI8btISWn7o=";
}
