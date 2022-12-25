{ lib, hostname, ... }:

{
  imports = [
    ../common/network.nix
  ];
  networking = {
    hostName = "${hostname}";
  };

  systemd = {
    network = {
      lab-network.enable = true;
      extraHosts = ''
        192.168.1.50 yui
        192.168.1.70 metatron
      '';
      networks = {
        "10-wired" = {
          name = "enp1s0";
          dns = [ "192.168.1.40" "127.0.0.1" ];
          address = [ "192.168.1.60" ];
          gateway = [ "192.168.1.1" ];
        };
      };
    };
  };
}
