{
  lib,
  modulesPath,
  hostname,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    (modulesPath + "/profiles/base.nix")
  ];
  isoImage = {
    edition = builtins.replaceStrings [ "liveimg-" "-iso" ] [ "" "" ] hostname;
    squashfsCompression = "zstd -Xcompression-level 6";
  };
  boot.supportedFilesystems = lib.mkForce [
    "btrfs"
    "cifs"
    "f2fs"
    "ntfs"
    "vfat"
    "xfs"
  ];
  hardware.enableAllHardware = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };
}
