{ hostname, lib, pkgs, ... }:

{
  networking = {
    wait-online = {
      timeout = 0;  # Disable wait online
    };
    hostName = "${hostname}";

    networkmanager = {
      enable = true;
      dhcp = "dhcpcd";
      wifi.powersave = false;
      firewallBackend = "nftables";
    };

    wireless = {
      enable = true;
      userControlled.enable = true;
    };
    dhcpcd = {
      enable = true;
      wait = "background";
    };
  };

  services = {
    nscd = {
      enable = false;
    };
  };
}
