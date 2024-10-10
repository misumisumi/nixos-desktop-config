{
  lib,
  hostname,
  ...
}:
{
  services = {
    nscd = {
      enable = true;
    };
  };
  networking = {
    hostName = "${hostname}";
    nftables.enable = true;
    firewall = {
      enable = false;
      trustedInterfaces = [
        "br0"
      ];
      allowedUDPPorts = [
        5353
        5355
      ];
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
          DHCP = "yes";
          address = [ "192.168.0.91/24" ];
          dns = [ "192.168.0.1" ];
          gateway = [ "192.168.0.1" ];
          dhcpV4Config = {
            UseDomains = true;
          };
          dhcpV6Config = {
            UseDomains = true;
          };
          ipv6AcceptRAConfig = {
            UseDomains = true;
          };
        };
      };
    };
  };
}
