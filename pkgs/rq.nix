{
  lib,
  buildGoModule,
  fetchFromSourcehut,
}:
buildGoModule rec {
  name = "rq";
  version = "0.0.13";

  src = fetchFromSourcehut {
    owner = "~charles";
    repo = "rq";
    rev = "v${version}";
    hash = "sha256-5cG9MIN5YZLsfeSvHwTpfrW9W+VSntTR3T0ocsg4v8g=";
  };

  vendorHash = "sha256-c8cbou+4bucZm4dexPZbYU1Pr+X1fV23Og8O17okhnA=";
}
