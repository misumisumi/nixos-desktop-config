{
  config,
  pkgs,
  user,
  ...
}: {
  boot = {
    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };
    loader.timeout = 10;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "v4l2loopback"
      "snd-aloop"
    ];
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