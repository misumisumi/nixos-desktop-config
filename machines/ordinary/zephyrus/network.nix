{ lib, hostname, ... }:
let
  inherit (import ../../path-relove.nix) commonDir;
in
{
  imports = [
    (commonDir + "/network.nix")
  ];
  networking = {
    wireless = {
      enable = true;
      userControlled.enable = true;
    };
    dhcpcd = {
      enable = true;
      wait = "background";
    };
    hostName = "${hostname}";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        4713 # PulseAudio
        1701
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764; # KDE-connect
        }
        {
          from = 60000;
          to = 60011; # Mosh
        }
      ];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764; # KDE-connect
        }
        {
          from = 60000;
          to = 60011; # Mosh
        }
      ];
    };
  };

  systemd = {
    network = {
      lab-network.enable = true;
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
          address = [ "192.168.1.200" ];
        };
        "20-wired" = {
          name = "enp4s0f4u1u3";
          bridge = [ "br0" "univ" ];
        };
        "20-usb" = {
          name = "enp4s0f4u1u2";
          DHCP = "yes";
        };
        "30-br0" = {
          name = "br0";
          DHCP = "yes";
        };
      };
    };
  };
}
