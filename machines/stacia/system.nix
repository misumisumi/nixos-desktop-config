{ config, ... }:
{
  boot = {
    loader.timeout = 10;
    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
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
  services.pipewire.extraConfig.pipewire-pulse = {
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
  nix = {
    settings = {
      cores = 4;
      max-jobs = 3;
    };
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };
}
