{
  ghtkn,
  ...
}:
{
  systemd.user.enable = true;

  systemd.user.services.ghtkn-agent = {
    Unit = {
      Description = "ghtkn agent";
    };

    Service = {
      Type = "simple";
      ExecStart = "${ghtkn}/bin/ghtkn agent start";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
