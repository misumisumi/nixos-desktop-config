{ hostname, lib, pkgs, ... }:

{
  networking = {
    wireless = {
      enable = true;
    };
    useDHCP = lib.mkDefault true;
    dhcpcd = {
      enable = true;
      wait = "background";
    };
    hostName = "${hostname}";
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
        "10-wireless" = {
          name = "wlp2s0";
          DHCP = "yes";
        };
        "20-br0" = {
          DHCP = "yes";
        };
        "20-wired" = {
          name = "enp4s0f4u1u3";
          bridge = [ "br0" ];
        };
      };
    };
  };
}
# WiFi setting
# networking = {
#   wireless = {
#     networks = {
#       "<name>" = {
#         psk = ""; # psk hash if null psk is NONE
#         priority = "";
#       };
#     };
#   };
# };

#  networking.interfaces.enp8s0.useDHCP = true;
#  networking.interfaces.br0.useDHCP = false;
#  networking.bridges = {
#    "br0" = {
#      interfaces = [ "enp8s0" ];
#    };
#  };
# networking.interfaces.br0.ipv4.addresses = [ {
#   address = "10.10.10.11";
#   prefixLength = 24;
# } ];
# networking.defaultGateway = "10.10.10.1";
# networking.nameservers = ["10.10.10.1" "8.8.8.8"];
