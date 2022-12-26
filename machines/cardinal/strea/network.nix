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
  };

  systemd = {
    network = {
      networks = {
        "10-wired" = {
          name = "enp1s0";
          dns = [ "192.168.1.40" "127.0.0.1" ];
          address = [ "192.168.1.60" ];
          gateway = [ "192.168.1.1" ];
        };
      };
    };
  };
}
