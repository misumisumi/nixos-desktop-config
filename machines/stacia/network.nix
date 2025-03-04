{ hostname, ... }:
{
  services = {
    nscd = {
      enable = true;
    };
  };
  networking = {
    hostName = "${hostname}";
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
        "br0".netdevConfig = {
          Kind = "bridge";
          Name = "br0";
        };
      };
      networks = {
        "10-wired" = {
          name = "enp34s0";
          bridge = [ "br0" ];
        };
        "20-br0" = {
          name = "br0";
          address = [ "133.24.91.38/23" ];
          dns = [
            "133.24.72.30"
            "133.24.64.20"
            "133.24.80.200"
          ];
          gateway = [ "133.24.90.254" ];
        };
      };
    };
  };
}
