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
        "lxdbr0"
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
            MACAddress = "56:47:6a:94:2d:34";
          };
          extraConfig = ''
            [Bridge]
            VLANFiltering=1
            DefaultPVID=1
          '';
        };
      };
      networks = {
        "20-wired" = {
          name = "enp5s0";
          bridge = [ "br0" ];
          bridgeVLANs = [
            {
              bridgeVLANConfig = {
                VLAN = "10";
                PVID = 1;
                EgressUntagged = 1;
              };
            }
            {
              bridgeVLANConfig = {
                VLAN = "30";
              };
            }
          ];
        };
        "30-br0" = {
          name = "br0";
          DHCP = "yes";
        };
      };
    };
  };
}
