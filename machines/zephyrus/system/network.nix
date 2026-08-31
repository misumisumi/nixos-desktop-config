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
            authentication.saePasswordsFile = config.sops.secrets.AP_password.path;
          };
        };
      };
    };
  };
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    openFirewall = true;
  };
  networking = {
    wg-quick = {
      interfaces = {
        wg0 = {
          autostart = false;
          mtu = 1280;
          address = [
            "10.250.0.50/24"
          ];
          dns = [ "10.250.0.1" ];
          peers = [
            {
              allowedIPs = [
                "10.250.0.0/24"
                "192.168.1.0/24"
              ];
              endpoint = "oci.misumi-sumi.com:443";
              publicKey = "BR2XCDtghHRZYqGryTPbal+Ms7gYlgzN+b+AAlWGIms=";
              presharedKeyFile = config.sops.secrets.wg_peer_oci_presharedKey.path;
              persistentKeepalive = 25;
            }
          ];
          privateKeyFile = config.sops.secrets.wg_privateKey.path;
        };
      };
    };

    wireless = {
      enable = true;
      userControlled = true;
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
        "50G_NETWORK_secure50" = {
          pskRaw = "ext:HOME";
          priority = 5;
        };
        "ASUS_RT-AC85U_5G" = {
          pskRaw = "ext:LOGGE";
          priority = 6;
        };
        "GL-MT3000-32f-5G" = {
          pskRaw = "ext:TRAVEL";
          priority = 7;
        };
        "eduroam" = {
          priority = 20;
          auth = ''
            scan_ssid=1
            key_mgmt=WPA-EAP
            eap=PEAP
            phase2="auth=MSCHAPV2"
            identity="dizzy6572@student.tohoku.ac.jp"
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
        "aist-guest" = {
          pskRaw = "ext:AIST_GUEST";
          priority = 40;
        };
      };
    };
    hostName = "${hostname}";
    nftables.enable = true;
    firewall = {
      enable = true;
      checkReversePath = "loose";
      trustedInterfaces = [
        "ap*"
        "br*"
        "dev*"
        "incus*"
        "waydroid0"
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
