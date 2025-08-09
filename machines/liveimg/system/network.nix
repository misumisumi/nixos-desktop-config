{
  lib,
  ...
}:
{
  networking = {
    wireless.enable = false;
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

  services = {
    nscd = {
      enable = false;
    };
  };
  system.nssModules = lib.mkForce [ ];
}
