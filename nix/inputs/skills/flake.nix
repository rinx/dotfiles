{
  description = "Agent Skills";

  inputs = {
    agent-skills.url = "github:Kyure-A/agent-skills-nix";

    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };

    ast-grep-skill = {
      url = "github:ast-grep/agent-skill";
      flake = false;
    };
  };

  outputs =
    {
      self,
      agent-skills,
      anthropic-skills,
      ast-grep-skill,
      ...
    }:
    {
      homeManagerModules.default =
        { ... }@args:
        import ./default.nix (
          args
          // {
            inherit
              agent-skills
              anthropic-skills
              ast-grep-skill
              ;
          }
        );
    };
}
