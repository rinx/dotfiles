{
  lib,
  buildGoModule,
  charles-rq,
}:
buildGoModule {
  name = "rq";

  src = charles-rq;

  vendorHash = "sha256-YQ/uqudChgbXch8hn3zMsn2CeG/NytXdHV1JsRlU5aA=";
}
