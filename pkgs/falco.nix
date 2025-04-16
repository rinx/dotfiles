{
  lib,
  buildGoModule,
  ysugimoto-falco,
}:
buildGoModule {
  name = "falco";

  src = ysugimoto-falco;

  vendorHash = "sha256-uZ2Jr7epCXRz9XKclKWWjP6CVPSrZGrJxkwaYVsrZqk=";

  ldflags = [
    "-X main.version=revision:${ysugimoto-falco.rev}"
  ];
}
