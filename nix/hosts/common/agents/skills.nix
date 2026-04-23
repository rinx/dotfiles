{
  lib,
  agent-skills,
  anthropic-skills,
  ast-grep-skill,
  duckdb-skills,
  rego-skill,
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
        idPrefix = "anthropic";
      };
      ast-grep = {
        path = ast-grep-skill;
        subdir = "ast-grep/skills";
      };
      duckdb = {
        path = duckdb-skills;
        subdir = "skills";
        idPrefix = "duckdb";
      };
      rego = {
        path = rego-skill;
      };
      local = {
        path = ./skills;
      };
    };

    skills.enable = [
      "anthropic/skill-creator"

      "duckdb/attach-db"
      "duckdb/convert-file"
      "duckdb/duckdb-docs"
      "duckdb/query"
      "duckdb/read-file"
      "duckdb/s3-explore"
    ];

    skills.enableAll = [
      "ast-grep"
      "rego"
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
