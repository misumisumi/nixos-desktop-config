{ config, ... }:
{
  networking.hostId = "dade0dc9";
  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
  };
}
