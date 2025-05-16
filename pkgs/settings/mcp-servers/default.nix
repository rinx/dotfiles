{
  lib,
  pkgs,
  mcp-servers-nix,
}:
let
  mcp-servers = mcp-servers-nix.lib.mkConfig pkgs {
    programs = {
      fetch.enable = true;
      git.enable = true;
      github = {
        enable = true;
        passwordCommand = ''echo "GITHUB_PERSONAL_ACCESS_TOKEN=''$(${pkgs.gh}/bin/gh auth token)"'';
      };
    };
  };
in
pkgs.concatTextFile {
  name = "mcp-servers.json";
  destination = "/config/mcp-servers.json";
  files = [ mcp-servers ];
}
