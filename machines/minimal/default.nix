{ pkgs, wm, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./gpu.nix
  ];

  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };
}
