{
  lib,
  pkgs,
  config,
  user,
  ...
}:
{
  boot = {
    kernel.sysctl = {
      "vm.swappiness" = lib.mkForce 10; # swap is only used when RAM is full
    };
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelParams = [
      "amd_pstate=active"
    ];
    kernelModules = [
      "v4l2loopback"
      "snd-aloop"
    ];
  };
  users.users.${user}.extraGroups = [ "user" ];
  services = {
    printing = {
      drivers = with pkgs; [
        cnijfilter2
        canon-cups-ufr2
      ];
    };
    pipewire.extraConfig.pipewire-pulse = {
      native-protocol-tcp = {
        pulse.cmd = [
          {
            cmd = "load-module";
            args = "module-native-protocol-tcp";
            flags = [
              "port=4656"
              "auth-anonymous=1"
            ];
          }
        ];
      };
    };
  };
  nix = {
    settings = {
      cores = 4;
      max-jobs = 3;
    };
    extraOptions = ''
      http-connections = 50
    '';
  };
}
