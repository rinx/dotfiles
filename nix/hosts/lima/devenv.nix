{
  self,
  ...
}:
{
  imports = [
    self.nixosModules.ghtkn-agent
  ];

  services.ghtkn-agent.enable = true;

  environment.sessionVariables = {
    GHTKN_BACKEND = "agent";
  };

}
