# sandbox-vm is used for claude-code sandboxing
{
  pkgs,
  ...
}@inputs:
{
  imports = [ ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.llm-agents.overlays.default
    ];
  };

  networking.hostName = "sandbox";

  environment.sessionVariables = {
    NVIM_DISABLE_TS_PARSER_INSTALL = 1;
  };

  environment.systemPackages = with pkgs; [
    llm-agents.claude-code
    ollama
    rsync
  ];
}
