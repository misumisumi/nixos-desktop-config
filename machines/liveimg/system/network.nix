{
  lib,
  ...
}:
{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      dhcp = "dhcpcd";
      wifi.powersave = false;
    };

    dhcpcd = {
      enable = true;
      wait = "background";
    };
  };
}
