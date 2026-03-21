{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.gpg-agent = {
    enable = false;
  };
}
