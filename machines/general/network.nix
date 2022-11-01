{ hostname, lib, pkgs, ... }:

{
  networking = {
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
  system.nssModules = lib.mkForce [];
}
