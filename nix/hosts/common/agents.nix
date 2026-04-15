{
  config,
  lib,
  pkgs,
  ...
}@inputs:
{
  imports = [
    inputs.agent-skills.homeManagerModules.default
  ];

  home.file = {
    ".claude/CLAUDE.md".source = ./agents/AGENTS.md;
    ".claude/rules" = {
      source = ./agents/rules;
      recursive = true;
    };
  };
}
