{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.hosts = {
    "192.168.0.29" = [ "ei5unis" ];
    "192.168.0.122" = [ "ei5nas3" ];
  };
  services = {
    rpcbind.enable = true;
    autofs = {
      enable = true;
      debug = true;
      autoMaster = ''
        /home/speech/splab file:${config.sops.secrets."auto.splab".path} --timeout 300
      '';
    };
  };
  fileSystems = {
    "splab" = {
      device = "ei5nas3:/volume7/splab3etc/6";
      fsType = "nfs";
      options = [
        "noauto"
        "rw"
        "hard"
        "intr"
      ];
      mountPoint = "/home/speech/splab/6";
    };
  };
}
