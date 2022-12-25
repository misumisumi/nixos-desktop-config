{ config, pkgs, user, ... }:
{
  nix = {
    settings = {
      cores = 4;
      max-jobs = 2;
    };
    extraOptions = ''
      binary-caches-parallel-connections = 8
    '';
  };
}
