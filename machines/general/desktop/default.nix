{ wm, ... }:
let
  inherit (import ../../path-relove.nix) commonDir appDir;
in
{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./gpu.nix
    (commonDir + "/pulseaudio.nix")
    (commonDir + "/printer.nix")
    (appDir + "/desktop/wm/${wm}/xserver.nix")
    (appDir + "/virtualisation/podman.nix")
  ];
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 4
    '';
  };
}
