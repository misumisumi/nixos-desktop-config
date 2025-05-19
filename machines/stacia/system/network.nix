{ hostname, ... }:
{
  services = {
    nscd = {
      enable = true;
    };
  };
  networking = {
    hostName = "${hostname}";
    hostId = "7dfa348e";
    interfaces.enp34s0.wakeOnLan.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [
        "br0"
        "incusbr0"
        "k8sbr0"
      ];
      # allowedUDPPorts = [
      #   4010
      # ];
      # allowedTCPPorts = [
      #   4713 # PulseAudio
      # ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764; # KDE-connect
        }
        # { from = 60000;
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
        "br0".netdevConfig = {
          Kind = "bridge";
          Name = "br0";
          MACAddress = "2e:55:7e:5e:a3:0e";
        };
      };
      networks = {
        "10-wired" = {
          name = "enp34s0";
          bridge = [ "br0" ];
        };
        "20-br0" = {
          name = "br0";
          address = [ "172.20.110.112/21" ];
          gateway = [ "172.20.110.1" ];
          dns = [
            "172.20.110.4"
            "172.20.110.54"
            "172.20.110.1"
          ];
          extraConfig = ''
            Broadcast="172.20.111.255"
          '';
        };
      };
    };
  };
}
