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
  services = {
    nscd = {
      enable = true;
    };
  };
  networking = {
    hostName = "${hostname}";
    hostId = "bcf1bfe4";
    interfaces.enp5s0.wakeOnLan.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [
        "br0"
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
        };
        "br1" = {
          netdevConfig = {
            Kind = "bridge";
            Name = "br1";
          };
          bridgeConfig = {
            VLANFiltering = true;
            DefaultPVID = 101;
          };
        };
        devnode = {
          netdevConfig = {
            Kind = "vlan";
            Name = "devnode";
            MACAddress = "6d:ff:2e:62:27:31";
          };
          vlanConfig = {
            Id = 101;
          };
        };
        devk8s = {
          netdevConfig = {
            Kind = "vlan";
            Name = "devk8s";
            MACAddress = "ef:e2:93:7e:94:e5";
          };
          vlanConfig = {
            Id = 102;
          };
        };
        devnfs = {
          netdevConfig = {
            Kind = "vlan";
            Name = "devnfs";
            MACAddress = "23:ad:d6:5b:f1:5a";
          };
          vlanConfig = {
            Id = 103;
          };
        };
      };
      networks = {
        "10-wired" = {
          matchConfig = {
            MACAddress = "f0:2f:74:dc:3b:4b";
          };
          vlan = [
            "devnode"
            "devk8s"
            "devnfs"
          ];
          bridge = [ "br0" ];
        };
        "20-br0" = {
          name = "br0";
          DHCP = "yes";
        };
        "20-devnode" = {
          name = "devnode";
          bridge = [ "br1" ];
          bridgeVLANs = [
            {
              PVID = 101;
              EgressUntagged = 101;
            }
          ];
        };
        "20-devk8s" = {
          name = "devk8s";
          bond = [ "br1" ];
          bridgeVLANs = [
            {
              PVID = 102;
              EgressUntagged = 102;
            }
          ];
        };
        "20-devnfs" = {
          name = "devnfs";
          bond = [ "devbr1" ];
          bridgeVLANs = [
            {
              PVID = 103;
              EgressUntagged = 103;
            }
          ];
        };
        "30-br1" = {
          name = "br1";
          networkConfig = {
            LinkLocalAddressing = "no";
            LLDP = "no";
            EmitLLDP = "no";
            IPv6AcceptRA = "no";
            IPv6SendRA = "no";
          };
          bridgeVLANs = [
            {
              VLAN = "101-103";
            }
          ];
        };
      };
    };
  };
}
