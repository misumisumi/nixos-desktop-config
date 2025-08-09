{ config, pkgs, ... }:
{
  sops.secrets = {
    "openfortivpn/config" = {
      sopsFile = ../../../../../sops/system/openfortivpn/config;
      format = "binary";
      mode = "0600";
    };
  };
  systemd.services.openfortivpn = {
    description = "Launch openfortivpn";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.openfortivpn}/bin/openfortivpn -c ${
        config.sops.secrets."openfortivpn/config".path
      }";
      PrivateTmp = true;
      Restart = "on-failure";
      OOMScoreAdjust = -100;
    };
  };
}
