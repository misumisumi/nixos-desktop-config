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
            VLANFiltering = false;
            DefaultPVID = 1;
          };
        };
        # dev-cluster-lan = {
        #   netdevConfig = {
        #     Kind = "vlan";
        #     Name = "dev-cluster-lan";
        #     MACAddress = "6d:ff:2e:62:27:31";
        #   };
        #   vlanConfig = {
        #     Id = 210;
        #   };
        # };
      };
      networks = {
        "10-wired" = {
          matchConfig = {
            MACAddress = "f0:2f:74:dc:3b:4b";
          };
          bridge = [ "br0" ];
        };
        "20-br0" = {
          name = "br0";
          DHCP = "yes";
        };
        # "20-devnode" = {
        #   name = "devnode";
        #   bridge = [ "br1" ];
        #   bridgeVLANs = [
        #     {
        #       PVID = 101;
        #       EgressUntagged = 101;
        #     }
        #   ];
        # };
        # "20-dev-cluster-lan" = {
        #   name = "devnode";
        #   bridge = [ "br1" ];
        # };
        # "30-br1" = {
        #   name = "br1";
        #   networkConfig = {
        #     LinkLocalAddressing = "no";
        #     LLDP = "no";
        #     EmitLLDP = "no";
        #     IPv6AcceptRA = "no";
        #     IPv6SendRA = "no";
        #   };
        #   bridgeVLANs = [
        #     {
        #       VLAN = "210";
        #     }
        #   ];
        # };
      };
    };
  };
}
