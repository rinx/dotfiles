{
  lib,
  agent-skills,
  anthropic-skills,
  ast-grep-skill,
  ...
}:
{
  imports = [
    (import "${agent-skills.outPath}/modules/home-manager/agent-skills.nix" {
      inherit lib;
      inputs = { };
    })
  ];

  programs.agent-skills = {
    enable = true;
    sources = {
      anthropic = {
        path = anthropic-skills;
        subdir = "skills";
      };
      ast-grep = {
        path = ast-grep-skill;
        subdir = "ast-grep/skills";
      };
    };

    skills.enable = [
      "skill-creator"
    ];

    skills.enableAll = [
      "ast-grep"
    ];

    targets = {
      agents = {
        dest = ".agents/skills";
        structure = "copy-tree";
      };
      claude = {
        dest = ".claude/skills";
        structure = "copy-tree";
      };
    };
  };
}
