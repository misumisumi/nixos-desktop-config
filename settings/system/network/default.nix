{ lib, ... }:
let
  inherit (lib) mkDefault mkForce;
in
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
    nscd.enable = true;
    resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = mkDefault "false";
        FallbackDNS = [
          "1.1.1.1"
          "2606:4700:4700::1111"
          "8.8.8.8"
          "2001:4860:4860::8888"
        ];
      };
    };
  };

  networking = {
    useDHCP = mkDefault false; # Setting each network interafces
    nameservers = [
      "1.1.1.1"
      "2606:4700:4700::1111"
      "8.8.8.8"
      "2001:4860:4860::8888"
    ];
  };
}
