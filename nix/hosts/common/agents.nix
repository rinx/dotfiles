{
  config,
  lib,
  pkgs,
  ...
}@inputs:
{
  imports = [
    ./agents/skills.nix
  ];

  home.file = {
    ".claude/CLAUDE.md".source = ./agents/AGENTS.md;
    ".claude/rules" = {
      source = ./agents/rules;
      recursive = true;
    };
  };
}
