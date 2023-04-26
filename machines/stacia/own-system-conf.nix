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
      cores = 6;
      max-jobs = 4;
    };
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };
}