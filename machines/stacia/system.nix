{ config, ... }: {
  networking.hostId = "7dfa348e";
  boot = {
    loader.timeout = 10;
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
    };
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

