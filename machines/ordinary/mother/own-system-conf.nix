{ config, pkgs, user, ... }:
{
  boot = {
    loader.timeout = 10;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "v4l2loopback"
      "snd-aloop"
    ];
  };
  security.sudo = {
    extraRules = [
      {
        users = [ "${user}" ];
        commands =
          [
            {
              command = "${pkgs.xp-pen-driver}/bin/xp-pen-driver";
              options = [ "SETENV" "NOPASSWD" ];
            }
          ];
      }
    ];
  };

  nix = {
    settings = {
      cores = 6;
      max-jobs = 4;
    };
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };
}
