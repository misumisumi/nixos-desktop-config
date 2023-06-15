{hostname, ...}: {
  imports = [
    ../common/network.nix
  ];
  services = {
    nscd = {
      enable = true;
    };
  };
  networking = {
    hostName = "${hostname}";
    interfaces.enp5s0.wakeOnLan.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [
        "br0"
        "lxdbr0"
        "k8sbr0"
      ];
      # allowedUDPPorts = [
      #   4010
      # ];
      # allowedTCPPorts = [
      #   4713 # PulseAudio
      # ];
      # allowedUDPPortRanges = [
      #   {
      #     from = 1714;
      #     to = 1764; # KDE-connect
      #   }
      #   {
      #     from = 60000;
      #     to = 60011; # Mosh
      #   }
      # ];
      # allowedTCPPortRanges = [
      #   {
      #     from = 1714;
      #     to = 1764; # KDE-connect
      #   }
      #   {
      #     from = 60000;
      #     to = 60011; # Mosh
      #   }
      # ];
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
          name = "enp5s0";
          bridge = ["br0"];
        };
        "20-br0" = {
          name = "br0";
          dns = ["192.168.1.40" "127.0.0.1"];
          address = ["192.168.1.20"];
          gateway = ["192.168.1.1"];
        };
      };
    };
  };
}