#NOTE: NixOS/nixpkgs/pull/341596
# boot.zfs.package.latestCompatibleLinuxPackages is deprecated
# It would probably be better to use an LTS kernel, but for the time being we will use the current method of keeping up with the latest kernels.
{
  lib,
  pkgs,
  config,
  ...
}:
let
  isUnstable = config.boot.zfs.package == pkgs.zfsUnstable;
  zfsCompatibleKernelPackages = lib.filterAttrs (
    name: kernelPackages:
    (builtins.match "linux_[0-9]+_[0-9]+" name) != null
    && (builtins.tryEval kernelPackages).success
    && (
      (!isUnstable && !kernelPackages.zfs.meta.broken)
      || (isUnstable && !kernelPackages.zfs_unstable.meta.broken)
    )
  ) pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in
{
  #NOTE: this might jump back and worth as kernel get added or removed.
  boot = {
    kernelPackages = latestKernelPackage;
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
  };
}
