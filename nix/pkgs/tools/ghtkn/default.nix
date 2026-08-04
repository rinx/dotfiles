{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ghtkn";
  version = "0.3.6";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "ghtkn";
    rev = "v${version}";
    hash = "sha256-yFfDpeLcDATXPDZbSqYjE3KrI0BtpfeREqg+nI5xEZE=";
  };

  vendorHash = "sha256-cBpTQu5yO9p+UvIrAEVxRMddwbX5ay4zVNShfmullyg=";
}
