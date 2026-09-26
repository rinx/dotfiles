{
  pkgs,
  ...
}:
{
  systemd.user.enable = true;

  systemd.user.services.ollama-serve = {
    Unit = {
      Description = "ollama serve";
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
      Restart = "on-failure";
    };

    # NOTE: this service is disbled by default.
    # to run, `systemctl --user start ollama-serve`
    Install = {
      WantedBy = [ ];
    };
  };
}
