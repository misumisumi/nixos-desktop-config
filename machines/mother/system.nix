{ config
, pkgs
, user
, ...
}: {
  networking.hostId = "bcf1bfe4";
  boot = {
    loader.timeout = 10;
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "v4l2loopback"
      "snd-aloop"
    ];
    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };
  };
  environment.systemPackages = with pkgs; [ xp-pen-driver ];
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
