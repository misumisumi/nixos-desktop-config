{ lib
, hostname
, ...
}: {
  services = {
    nscd = {
      enable = true;
    };
  };
  networking = {
    hostName = "${hostname}";
    firewall = {
      enable = true;
      trustedInterfaces = [
        "br0"
      ];
      # allowedUDPPorts = [
      #   4010
      # ];
      # allowedTCPPorts = [
      #   4713 # PulseAudio
      # ];
      allowedUDPPortRanges = [
        # {
        #   from = 60000;
        #   to = 60011; # Mosh
        # }
      ];
      allowedTCPPortRanges = [
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
          name = "enp0s31f6";
          bridge = [ "br0" ];
        };
        "20-br0" = {
          name = "br0";
          address = [ "192.168.0.89" ];
          dns = [ "133.24.72.30" ];
          gateway = [ "192.168.0.1" ];
        };
      };
    };
  };
}
