{
  lib,
  buildGoModule,
  source,
}:
buildGoModule {
  name = "rq";

  src = source;

  vendorHash = "sha256-YQ/uqudChgbXch8hn3zMsn2CeG/NytXdHV1JsRlU5aA=";
}
