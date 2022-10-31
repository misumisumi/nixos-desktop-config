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
      networks = {
        "10-wireless" = {
          name = "wlp2s0";
          DHCP = "yes";
        };
        "20-wired" = {
          name = "enp4s0f4u1u3";
          DHCP = "yes";
        };
      };
    };
  };
}
