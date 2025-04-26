{
  lib,
  buildGoModule,
  charles-rq,
}:
buildGoModule {
  name = "rq";

  src = charles-rq;

  vendorHash = "sha256-fOq62QRx7BoE7RJielTnu1dtvkLy2FkzG59uuMQVLc4=";
}
