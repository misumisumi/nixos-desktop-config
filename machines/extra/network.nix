{ hostname, lib, pkgs, ... }:

{
  networking = {
    wireless = {
      enable = true;
      userControlled = {
        enable = true;
      };
      networks = {
        "ASUS_RT-AC85U_5G" = {
          pskRaw = "5376215bf67d31cac4df819ad719699b95f5e1c6986ffe84b0237c895caf23f5";
          priority = 10;
        };
      };
    };
    useDHCP = lib.mkDefault true;
    hostName = "${hostname}";
    # bridges = {
    #   interfaces = [ "" ];
    # };
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
