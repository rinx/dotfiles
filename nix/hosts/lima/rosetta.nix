{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];

  options = {
    services.lima-rosetta-cdi = {
      enable = lib.mkEnableOption "use rosetta aot caching";
    };
  };

  # NOTE: these scripts are borrowed from
  # https://github.com/lima-vm/lima/blob/bc7ba1ec50b4cf90747a3a600e66648823a22480/pkg/driver/vz/boot.Linux/05-rosetta-volume.sh
  config = lib.mkIf config.services.lima-rosetta-cdi.enable {
    systemd.services.rosettad = {
      description = "Rosetta AOT Caching Daemon";
      wantedBy = [ "default.target" ];
      unitConfig.RequiresMountsFor = "/mnt/lima-rosetta";
      serviceConfig = {
        RuntimeDirectory = "rosettad";
        CacheDirectory = "rosettad";
        ExecStartPre = "+${pkgs.bash}/bin/bash -c 'rm -f /var/cache/rosettad/uds/rosetta.sock'";
        ExecStart = "/mnt/lima-rosetta/rosettad daemon /var/cache/rosettad";
        ExecStartPost = "+${pkgs.bash}/bin/bash -c 'while ! chmod go+w /var/cache/rosettad/uds/rosetta.sock; do sleep 1; done; mkdir -p /run/rosettad; ln -sf /var/cache/rosettad/uds/rosetta.sock /run/rosettad/rosetta.sock'";
        OOMPolicy = "continue";
        OOMScoreAdjust = -500;
      };
    };

    environment.etc."cdi/rosetta.yaml".text = ''
      cdiVersion: "0.6.0"
      kind: "lima-vm.io/rosetta"
      devices:
      - name: cached
        containerEdits:
          mounts:
          - hostPath: /var/cache/rosettad/uds/rosetta.sock
            containerPath: /run/rosettad/rosetta.sock
            options: [bind]
      annotations:
        org.mobyproject.buildkit.device.autoallow: true
    '';

    boot.binfmt.registrations.rosetta = {
      interpreter = "/mnt/lima-rosetta/rosetta";
      magicOrExtension = ''\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x3e\x00'';
      mask = ''\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'';
      openBinary = true;
      matchCredentials = true;
      fixBinary = true;
      wrapInterpreterInShell = false;
    };

    virtualisation.docker.daemon.settings.features.cdi = true;
  };
}
