{ lib, ... }:
{
  boot = {
    loader.timeout = 10;
    supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
    # Use RAM disk as /tmp
    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
    };
  };
  nix = {
    # settings = {
    #   cores = "0";
    #   max-jobs = "auto";
    # };
    extraOptions = ''
      binary-caches-parallel-connections = 4
    '';
  };
}
