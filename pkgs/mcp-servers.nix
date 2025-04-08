{
  lib,
  pkgs,
  mcp-servers-nix,
}: let
  mcp-servers = mcp-servers-nix.lib.mkConfig pkgs {
    programs = {
      fetch.enable = true;
      filesystem = {
        enable = true;
        args = [
          "~/local/src/"
          "~/tmp"
        ];
      };
      git.enable = true;
      playwright.enable = true;
    };
  };
in pkgs.concatTextFile {
  name = "mcp-servers.json";
  destination = "/config/mcp-servers.json";
  files = [ mcp-servers ];
}
