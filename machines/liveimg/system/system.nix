{ lib, ... }:
{
  boot = {
    loader.timeout = 10;
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];
  };
  nix = {
    # settings = {
    #   cores = "0";
    #   max-jobs = "auto";
    # };
    extraOptions = ''
      http-connections = 25
    '';
  };
}
