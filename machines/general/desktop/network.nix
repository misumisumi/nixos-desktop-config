{ lib
, hostname
, ...
}: {
  networking = {
    hostName = "${hostname}";

    networkmanager = {
      enable = true;
      dhcp = "dhcpcd";
      wifi.powersave = false;
      firewallBackend = "nftables";
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
