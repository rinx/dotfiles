{
  lib,
  buildGoModule,
  fetchFromSourcehut,
}:
buildGoModule rec {
  pname = "rq";
  version = "v0.0.16";

  src = fetchFromSourcehut {
    owner = "~charles";
    repo = "rq";
    rev = "${version}";
    hash = "sha256-MTUuNIw8HD9LV/Q678M1xH7VzKViwMkPlz/LicLMNWY=";
  };

  vendorHash = "sha256-APmEsnfJ07ENzdIebrfNPSxypzTuRpCNhTvNK9n1Gmk=";
}
