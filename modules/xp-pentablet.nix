{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.xserver.xp-pentablet;
  dataDir = "/var/lib/xppenconf";
in
{
  options = {
    services.xserver.xp-pentablet = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to enable the xp-pen-tablet.
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    hardware.uinput.enable = true;

    environment.systemPackages = [ pkgs.xp-pentablet ]; # provides xsetwacom

    services.udev.packages = [ pkgs.xp-pentablet ];

    system.activationScripts.xp-pentablet-config.text = ''
      install -m 755 -d "${dataDir}/conf/xppen"
      find ${pkgs.xp-pentablet}/usr/lib/pentablet/conf -type f | while read -r file; do
        if [ ! -f ${dataDir}/conf/$(basename ''${file}) ]; then
          install -m 666 "''${file}" "${dataDir}/conf/xppen/$(basename ''${file})"
        fi
      done
    '';
  };
}
