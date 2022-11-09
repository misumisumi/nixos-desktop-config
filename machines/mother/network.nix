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
      netdevs = {
        "br0".netdevConfig = {
          Kind = "bridge";
          Name = "br0";
        };
      };
      networks = {
        "10-wired" = {
          name = "enp4s0";
          bridge = [ "br0" "univ" ];
        };
        "20-br0" = {
          name = "br0";
          dns = [ "192.168.1.40" "127.0.0.1" ];
          address = [ "192.168.1.20" ];
          gateway = [ "192.168.1.1" ];
        };
      };
    };
  };
}
