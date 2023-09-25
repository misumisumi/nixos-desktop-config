# From https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
{ lib
, pkgs
, config
, ...
}:
with lib; let
  cfg = config.virtualisation;
  tmpfileEntry = name: f: "f /dev/shm/${name} ${f.mode} ${f.user} ${f.group} -";
in
{
  options.virtualisation = {
    sharedMemoryFiles = mkOption {
      type = types.attrsOf (types.submodule ({ name, ... }: {
        options = {
          name = mkOption {
            visible = false;
            default = name;
            type = types.str;
          };
          user = mkOption {
            type = types.str;
            default = "root";
            description = "Owner of the memory file";
          };
          group = mkOption {
            type = types.str;
            default = "root";
            description = "Group of the memory file";
          };
          mode = mkOption {
            type = types.str;
            default = "0600";
            description = "Group of the memory file";
          };
        };
      }));
      default = { };
    };
    hugepages = {
      enable = mkEnableOption "Hugepages";

      defaultPageSize = mkOption {
        type = types.strMatching "[0-9]*[kKmMgG]";
        default = "1M";
        description = "Default size of huge pages. You can use suffixes K, M, and G to specify KB, MB, and GB.";
      };
      pageSize = mkOption {
        type = types.strMatching "[0-9]*[kKmMgG]";
        default = "1M";
        description = "Size of huge pages that are allocated at boot. You can use suffixes K, M, and G to specify KB, MB, and GB.";
      };
      numPages = mkOption {
        type = types.ints.positive;
        default = 1;
        description = "Number of huge pages to allocate at boot.";
      };
    };
    scream.enable = mkEnableOption "Scream";
  };

  config.systemd.tmpfiles.rules =
    mapAttrsToList tmpfileEntry cfg.sharedMemoryFiles;

  config.boot.kernelParams = optionals cfg.hugepages.enable [
    "default_hugepagesz=${cfg.hugepages.defaultPageSize}"
    "hugepagesz=${cfg.hugepages.pageSize}"
    "hugepages=${toString cfg.hugepages.numPages}"
  ];
  config.systemd.user = {
    services.scream = {
      enable = cfg.scream.enable;
      description = "Scream Receiver (For windows VM)";
      wantedBy = [ "default.target" ];
      # wants = [ "network-online.target" "pulseaudio.service" ]; # For pulseaudio
      wants = [ "network-online.target" "pipewire-pulse.service" ];
      environment.IS_SERVICE = "1";
      unitConfig = {
        StartLimitInterval = 200;
        StartLimitBurst = 2;
      };
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.scream}/bin/scream -i br0 -v";
        Restart = "on-failure";
      };
    };
  };
}
