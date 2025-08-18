{
  lib,
  buildGoModule,
  fetchFromSourcehut,
}:
buildGoModule rec {
  pname = "rq";
  version = "0.0.14";

  src = fetchFromSourcehut {
    owner = "~charles";
    repo = "rq";
    rev = "v${version}";
    hash = "sha256-SZnbjPiXW6mw3abyL2475sNq3s5Jw12D9ZqbLfvaHN8=";
  };

  vendorHash = "sha256-fOq62QRx7BoE7RJielTnu1dtvkLy2FkzG59uuMQVLc4=";
}
