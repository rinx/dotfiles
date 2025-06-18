{
  lib,
  buildGoModule,
  source,
}:
buildGoModule {
  name = "rq";

  src = source;

  vendorHash = "sha256-7HgIu5rI7SaMbmgRAOWF1sGEJtLNkAEHwsdfoffeV+c=";
}
