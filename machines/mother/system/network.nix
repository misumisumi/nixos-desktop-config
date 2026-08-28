{ hostname, pkgs, ... }:
{
  imports = [
    ../../../settings/system/network/vpn/l2tp
    ../../../settings/system/network/vpn/l2tp/tains.nix
  ];
  environment.systemPackages = with pkgs; [
    mstflint-cx3-support
  ];
  hardware.infiniband = {
    enable = true;
    guids = [
      "24be05ffff84ff60"
      "24be05ffff84ff61"
    ];
  };
  networking = {
    hostName = "${hostname}";
    hostId = "bcf1bfe4";
    # interfaces.enp5s0.wakeOnLan.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      checkReversePath = "loose";
      trustedInterfaces = [
        "br*"
        "dev*"
        "incus*"
        "waydroid0"
      ];
      allowedUDPPorts = [
        # 4010
        # 53 # DNS for incus
        # 67 # DHCP for incus
      ];
      allowedTCPPorts = [
        # 4713 # PulseAudio
        # 53 # DNS for incus
        # 67 # DHCP for incus
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764; # KDE-connect
        }
        # {
        #   from = 60000;
        #   to = 60011; # Mosh
        # }
      ];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764; # KDE-connect
        }
        # {
        #   from = 60000;
        #   to = 60011; # Mosh
        # }
      ];
    };
  };

  systemd = {
    network = {
      netdevs = {
        "br0" = {
          netdevConfig = {
            Kind = "bridge";
            Name = "br0";
            MACAddress = "56:47:6a:94:2d:34";
          };
          bridgeConfig = {
            VLANFiltering = true;
            DefaultPVID = 1;
          };
        };
        "br0.10" = {
          netdevConfig = {
            Name = "br0.10";
            Kind = "vlan";
          };
          vlanConfig = {
            Id = 10;
          };
        };
      };
      networks = {
        # "10-wired-2.5G" = {
        #   matchConfig = {
        #     MACAddress = "60:cf:84:a1:c1:18"; # 2.5G
        #   };
        #   bridge = [ "br0" ];
        # };
        "10-wired-1.0G" = {
          matchConfig = {
            MACAddress = "60:cf:84:a1:c1:19"; # 1G
          };
          bridge = [ "br0" ];
          bridgeVLANs = [
            {
              VLAN = 1;
            }
            {
              VLAN = 10;
            }
          ];
        };
        "20-br0" = {
          matchConfig.Name = "br0";
          DHCP = "yes";
          vlan = [ "br0.10" ];
        };
        "20-br0.10" = {
          matchConfig.Name = "br0.10";
          address = [ "192.168.2.11/24" ];
        };
      };
    };
  };
}
