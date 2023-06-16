{
  lib,
  hostname,
  ...
}: {
  imports = [
    ../common/network.nix
  ];
  services = {
    hostapd = {
      enable = false;
      ssid = "zephyrus";
      interface = "wlp2s0";
      wpaPassphrase = "FsP65sEZdvxMjZL";
    };
    nscd = {
      enable = true;
    };
  };

  networking = {
    wireless = {
      enable = true;
      userControlled.enable = true;
    };
    hostName = "${hostname}";
    firewall = {
      enable = true;
      trustedInterfaces = [
        "br0"
        "lxdbr0"
      ];
      allowedTCPPorts = [
        5353 # avahi
        4713 # PulseAudio
        1701
      ];
      allowedUDPPorts = [
        5353 # avahi
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
      useMyDots.enable = true;
      netdevs = {
        "br0".netdevConfig = {
          Kind = "bridge";
          Name = "br0";
        };
      };
      links = {
        "ethusb0" = {
          matchConfig = {
            MACAddress = "00:e0:4c:68:00:12";
          };
          linkConfig = {
            Name = "ethusb0";
          };
        };
      };
      networks = {
        "20-wired" = {
          name = "enp4s*";
          bridge = ["br0"];
        };
        "30-br0" = {
          name = "br0";
          DHCP = "yes";
        };
        "40-wireless" = {
          name = "wlp2s0";
          DHCP = "yes";
          address = ["192.168.1.200"];
        };
      };
    };
  };
}