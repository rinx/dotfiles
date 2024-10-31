{
  lib,
  buildGoModule,
  fetchFromSourcehut,
}:
buildGoModule rec {
  name = "rq";
  version = "0.0.10";

  src = fetchFromSourcehut {
    owner = "~charles";
    repo = "rq";
    rev = "v${version}";
    hash = "sha256-E++Ni3pN5g1c4vmP+/rOQsprlzIKhGJITbFGVitYKmU=";
  };

  vendorHash = "sha256-cILZxrT0lVIK3N662zYUmDg9EfhRBynO6jYoAX6aZwo=";
}
