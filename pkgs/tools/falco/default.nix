{
  lib,
  buildGoModule,
  ysugimoto-falco,
}:
buildGoModule {
  name = "falco";

  src = ysugimoto-falco;

  vendorHash = "sha256-5Kt5HHIbXmcwzTUVCxvDv8lWZgligFMOlow/rhO0FZE=";

  ldflags = [
    "-X main.version=revision:${ysugimoto-falco.rev}"
  ];
}
