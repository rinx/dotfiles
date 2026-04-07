# sandbox-vm is used for claude-code sandboxing
{
  pkgs,
  ...
}@inputs:
{
  imports = [ ];

  nixpkgs.overlays = [
    inputs.claude-code.overlays.default
  ];

  networking.hostName = "sandbox";

  environment.sessionVariables = {
    NVIM_DISABLE_TS_PARSER_INSTALL = 1;
  };

  environment.systemPackages = with pkgs; [
    claude-code
    rsync
  ];
}
