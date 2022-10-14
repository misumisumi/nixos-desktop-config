{ hostname, lib, pkgs, ... }:

{
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
        };
        "20-br0" = {
          DHCP = "yes";
        };
        "20-wired" = {
          name = "enp4s0f4u1u3";
          bridge = [ "br0" ];
        };
      };
    };
  };
}
