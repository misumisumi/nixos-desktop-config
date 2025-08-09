{ config, hostname, ... }:
{
  imports = [
    ../../../settings/system/network/vpn/l2tp
    ../../../settings/system/network/vpn/l2tp/tains.nix
  ];
  services = {
    hostapd = {
      enable = false;
      radios = {
        wlp2s0 = {
          countryCode = "JP";
          band = "2g";
          networks.wlp2s0 = {
            ssid = "zephyrus";
            authentication.saePasswordsFile = [ { password = "FsP65sEZdvxMjZL"; } ]; # Use saePasswordsFile if possible.
          };
        };
      };
    };
    nscd = {
      enable = true;
    };
  };
  networking = {
    wireless = {
      enable = true;
      userControlled.enable = true;
      secretsFile = config.sops.secrets.wireless.path;
      networks = {
        "Pixel_3770" = {
          pskRaw = "ext:PIXEL";
          priority = 100;
        };
        "SHIRASAGI_PR@NHK" = {
          pskRaw = "ext:SHIRASAGI";
          priority = 2;
        };
        "kosakaken4" = {
          pskRaw = "ext:KOSAKAKEN_NEW";
          priority = 2;
        };
        "kosakaken2-5G" = {
          pskRaw = "ext:KOSAKAKEN_SEMINAR";
          priority = 2;
        };
        "50G_NETWORK_secure50" = {
          pskRaw = "ext:HOME";
          priority = 5;
        };
        "ASUS_RT-AC85U_5G" = {
          pskRaw = "ext:LOGGE";
          priority = 6;
        };
        "eduroam" = {
          priority = 20;
          auth = ''
            scan_ssid=1
            key_mgmt=WPA-EAP
            eap=PEAP
            phase2="auth=MSCHAPV2"
            identity="k4caffdb0y@student.tohoku.ac.jp"
            altsubject_match="DNS:radius1.tains.tohoku.ac.jp"
            anonymous_identity="anonymous@student.tohoku.ac.jp"
            password=ext:EDUROAM_PASSWD
          '';
        };
        "aitolab_wlan1-an" = {
          pskRaw = "ext:ITONOSELAB";
          priority = 30;
        };
        "aitolab_wlan2-an" = {
          pskRaw = "ext:ITONOSELAB";
          priority = 30;
        };
        "aitolab_wlan3-an" = {
          pskRaw = "ext:ITONOSELAB";
          priority = 30;
        };
        "aitolab_wlan4-an_nose" = {
          pskRaw = "ext:ITONOSELAB";
          priority = 30;
        };
      };
    };
    hostName = "${hostname}";
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [
        "br0"
        "incusbr0"
        "k8sbr0"
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
      wait-online.ignoredInterfaces = [ "wlan0" ];
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
          bridge = [ "br0" ];
        };
        "30-br0" = {
          name = "br0";
          DHCP = "yes";
        };
        "40-wireless" = {
          name = "wlp2s0";
          DHCP = "yes";
          address = [ "192.168.1.200" ];
        };
      };
    };
  };
}
