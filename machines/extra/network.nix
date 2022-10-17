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
        "20-wired" = {
          name = "enp4s0f4u1u3";
          bridge = [ "br0" ];
        };
        "20-usb" = {
          name = "enp4s0f4u1u2";
          DHCP = "yes";
        };
        "30-univ" = {
          DHCP = "yes";
          address = [ "172.24.154.84" "172.24.154.70" ];
          gateway = [ "172.24.154.65" ];
          dns = [ "172.24.185.203" "172.24.185.204" ];
        };
        "30-br0" = {
          DHCP = "yes";
        };
      };
    };
  };
}
