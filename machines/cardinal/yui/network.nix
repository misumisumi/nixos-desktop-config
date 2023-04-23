{ lib, hostname, ... }:
let
  inherit (import ../../path-relove.nix) commonDir;
in
{
  imports = [
    (commonDir + "/network.nix")
  ];
  networking = {
    hostName = "${hostname}";
    firewall = {
      enable = false;
    };
    extraHosts = ''
      192.168.1.60 strea
      192.168.1.70 metatron
    '';
  };

  systemd = {
    network = {
      networks = {
        "10-wired" = {
          name = "enp4s0";
          dns = [ "192.168.1.40" "127.0.0.1" ];
          address = [ "192.168.1.20" ];
          gateway = [ "192.168.1.1" ];
        };
      };
    };
  };
}
