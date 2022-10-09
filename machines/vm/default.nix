{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
  ];
  
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 8
    '';
  };
}
