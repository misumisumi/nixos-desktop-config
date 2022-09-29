{ config, pkgs, ... }:
{
  systemd.services.openfortivpn = {
    description = "Launch openfortivpn";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.openfortivpn}/bin/openfortivpn -c ${config.sops.secrets."openfortivpn/config".path}";
    };
  };
}
