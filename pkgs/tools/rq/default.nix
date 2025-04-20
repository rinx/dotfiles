{
  lib,
  buildGoModule,
  charles-rq,
}:
buildGoModule {
  name = "rq";

  src = charles-rq;

  vendorHash = "sha256-GqqZg6uSL683jEYqkYl0AQ5AvJunV9SapHrtSxAgQH0=";
}
