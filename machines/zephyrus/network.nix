{ lib, hostname, ... }:

{
  imports = [
    ../common/network.nix
  ];
  networking = {
    wireless = {
      enable = true;
    };
    dhcpcd = {
      enable = true;
      wait = "background";
    };
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
        "10-wireless" = {
          name = "wlp2s0";
          DHCP = "yes";
          address = [ "192.168.1.50" ];
          gateway = [ "192.168.1.1" ];
        };
        "20-wired" = {
          name = "enp4s0f4u1u3";
          bridge = [ "br0" "univ" ];
        };
        "20-usb" = {
          name = "enp4s0f4u1u2";
          DHCP = "yes";
        };
        "30-br0" = {
          name = "br0";
          DHCP = "yes";
        };
      };
    };
  };
}
