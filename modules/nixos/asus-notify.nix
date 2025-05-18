{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.services.asus-notify;
in
{
  options = {
    services.asus-notify = {
      enable = mkEnableOption ''
        enable asus-notify
      '';
    };
  };
  config = mkIf cfg.enable {
    services.dbus.packages = with pkgs; [ asusctl ];

    systemd.user = {
      services.asus-notify = {
        description = "notification for asusctl";
        wantedBy = [ "default.target" ];
        wants = [ "dbus.socket" ];
        environment.IS_SERVICE = "1";
        unitConfig = {
          StartLimitInterval = 200;
          StartLimitBurst = 2;
        };
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.asusctl}/bin/asus-notify";
          Restart = "on-failure";
        };
      };
    };
  };
}
