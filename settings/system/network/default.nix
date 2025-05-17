{ lib, ... }:
{
  systemd = {
    network = {
      enable = true;
      wait-online = {
        timeout = 5; # Disable wait online
        anyInterface = true;
      };
    };
  };
  services = {
    resolved = {
      enable = true;
      # dnssec = "allow-downgrade";
      dnssec = lib.mkDefault "false";
      fallbackDns = [
        "1.1.1.1"
        "2606:4700:4700::1111"
        "8.8.8.8"
        "2001:4860:4860::8888"
      ];
    };
  };

  networking = {
    useDHCP = lib.mkDefault false; # Setting each network interafces
    nameservers = [
      "1.1.1.1"
      "2606:4700:4700::1111"
      "8.8.8.8"
      "2001:4860:4860::8888"
    ];
  };
  # system.nssModules = lib.mkForce [];
}
