{
  lib,
  buildGoModule,
  source,
}:
buildGoModule {
  name = "falco";

  src = source;

  vendorHash = "sha256-5Kt5HHIbXmcwzTUVCxvDv8lWZgligFMOlow/rhO0FZE=";

  ldflags = [
    "-X main.version=revision:${source.rev}"
  ];
}
