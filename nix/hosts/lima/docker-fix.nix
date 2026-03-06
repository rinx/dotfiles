{
  config,
  lib,
  ...
}:
{
  imports = [ ];

  options = {
    services.lima-docker-fix = {
      enable = lib.mkEnableOption "fixes to use docker daemon socket from host machine";
    };
  };

  config = lib.mkIf config.services.lima-docker-fix.enable {
    systemd.sockets.docker.socketConfig = lib.mkForce {
      SocketGroup = "users";
      ListenStream = [ "/var/run/docker.sock" ];
    };
  };
}
