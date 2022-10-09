{ pkgs, ... }:

{
  networking = {
    useDHCP = true;
    # bridges = {
    #   interfaces = [ "" ];
    # };
  };
}
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
