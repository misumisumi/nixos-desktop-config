{ lib, ... }:

{
  systemd = {
    network = {
      enable = true;
      wait-online = {
        timeout = 0; # Disable wait online
      };
    };
  };

  services = {
    resolved = {
      enable = true;
      fallbackDns = [
        "1.1.1.1"
        "2606:4700:4700::1111"
        "8.8.8.8"
        "2001:4860:4860::8888"
        "192.168.1.40"
        "192.168.1.1"
      ];
    };
  };

  networking = {
    useDHCP = lib.mkDefault false; # Setting each network interafces
  };
  # system.nssModules = lib.mkForce [];
}
