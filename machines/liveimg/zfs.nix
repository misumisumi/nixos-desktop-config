{ config, ... }:
{
  networking.hostId = "105fa42b";
  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
  };
}
