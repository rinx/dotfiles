{
  lib,
  agent-skills,
  anthropic-skills,
  ast-grep-skill,
  google-skills,
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
      google = {
        path = google-skills;
        subdir = "skills/cloud";
      };
      local = {
        path = ./skills;
      };
    };

    skills.enable = [
      # anthropic
      "skill-creator"

      # google
      "cloud-run-basics"
      "gcloud"
      "gke-basics"
      "google-cloud-waf-reliability"
    ];

    skills.enableAll = [
      "ast-grep"
      "local"
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
