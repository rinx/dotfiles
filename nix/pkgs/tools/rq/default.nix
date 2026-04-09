{
  lib,
  buildGoModule,
  fetchFromSourcehut,
}:
buildGoModule rec {
  pname = "rq";
  version = "0.0.15";

  src = fetchFromSourcehut {
    owner = "~charles";
    repo = "rq";
    rev = "v${version}";
    hash = "sha256-71jXbx3OB63aAIe8ZVFMAWWUv6uAV9UuEUuEU/8Zr3c=";
  };

  vendorHash = "sha256-cWjYKRvcLZBaRa/0UQBHDGclP23aHtmDmEhec5mh+N4=";
}
