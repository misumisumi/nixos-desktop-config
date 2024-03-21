{ hostname, ... }: {
  services = {
    nscd = {
      enable = true;
    };
  };
  networking = {
    hostName = "${hostname}";
    interfaces.enp5s0.wakeOnLan.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [
        "br0"
        "incusbr0"
        "k8sbr0"
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
          };
          extraConfig = ''
            [Bridge]
            VLANFiltering=1
            DefaultPVID=1
          '';
        };
        "br1" = {
          netdevConfig = {
            Kind = "bridge";
            Name = "br1";
          };
          extraConfig = ''
            [Bridge]
            VLANFiltering=1
            DefaultPVID=100
          '';
        };
        home = {
          netdevConfig = {
            Kind = "vlan";
            Name = "home";
            MACAddress = "56:47:6a:94:2d:34";
          };
          vlanConfig = {
            Id = 1;
          };
        };
        dev-server-host = {
          netdevConfig = {
            Kind = "vlan";
            Name = "dev-server-host";
            MACAddress = "7f:11:b1:60:a4:74";
          };
          vlanConfig = {
            Id = 100;
          };
        };
        dev-k8s = {
          netdevConfig = {
            Kind = "vlan";
            Name = "dev-server-host";
            MACAddress = "7f:11:b1:60:a4:84";
          };
          vlanConfig = {
            Id = 101;
          };
        };
        dev-nfs = {
          netdevConfig = {
            Kind = "vlan";
            Name = "dev-server-host";
            MACAddress = "7f:11:b1:60:a4:94";
          };
          vlanConfig = {
            Id = 102;
          };
        };
      };
      networks = {
        "10-wired" = {
          name = "enp5s0";
          bridge = [ "br0" ];
        };
        "20-br0" = {
          name = "br0";
          vlan = [ "home" "dev" ];
          bridgeVLANs = [
            {
              bridgeVLANConfig = {
                VLAN = "1";
              };
            }
            {
              bridgeVLANConfig = {
                VLAN = "100-102";
              };
            }
          ];
        };
        "30-home" = {
          name = "home";
          DHCP = "yes";
        };
        "40-dev-server-host" = {
          name = "dev-server-host";
          bridge = [ "br1" ];
          DHCP = "no";
        };
        "40-dev-k8s" = {
          name = "dev-k8s";
          bridge = [ "br1" ];
          DHCP = "no";
        };
        "40-dev-nfs" = {
          name = "dev-nfs";
          bridge = [ "br1" ];
          DHCP = "no";
        };
        "50-br1" = {
          name = "br1";
          DHCP = "no";
          bridgeVLANs = [
            {
              bridgeVLANConfig = {
                VLAN = "100-102";
                PVID = 100;
                EgressUntagged = 100;
              };
            }
          ];
        };
      };
    };
  };
}
