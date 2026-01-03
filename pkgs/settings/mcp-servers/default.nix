{
  lib,
  pkgs,
  mcp-servers-nix,
}:
let
  mcp-servers = mcp-servers-nix.lib.mkConfig pkgs {
    programs = {
      git.enable = true;
    };
  };
in
pkgs.concatTextFile {
  name = "mcp-servers.json";
  destination = "/config/mcp-servers.json";
  files = [ mcp-servers ];
}
