{ hostname, ... }:
{
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
        "incusbr0"
        "k8sbr0"
        "waydroid0"
      ];
      allowedUDPPorts = [
        # 4010
      ];
      allowedTCPPorts = [
        # 4713 # PulseAudio
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
          name = "enp5s0";
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
