let
  rootDevice = "/dev/disk/by-id/nvme-HFM001TD3JX013N_CY0CN03771120CM4Q";
in
{
  disko.devices = {
    disk = {
      root = {
        type = "disk";
        device = rootDevice;
        content = {
          type = "gpt";
          partitions = {
            boot = {
              priority = 1;
              size = "512M";
              type = "EF00";
              label = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              label = "LUKSROOT";
              content = {
                type = "luks";
                name = "luksroot";
                extraOpenArgs = [ ];
                passwordFile = "/tmp/secret.key";
                settings.allowDiscards = true;
                additionalKeyFiles = [ ];
                extraFormatArgs = [ ];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/persist" = {
                      mountpoint = "/nix/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    # Sub(sub)volume doesn't need a mountpoint as its parent is mounted
                    "/persist/var/cache" = { }; # don't snapshot
                    "/persist/var/log" = { }; # don't snapshot
                    "/persist/var/tmp" = { }; # don't snapshot
                    "/persist/home" = { };
                    # snapshot dirs
                    "/persist/.snapshot" = { };
                    "/persist/home/.snapshot" = { };
                    # don't snapshot but place persisted files here
                    "/persist-alt" = {
                      mountpoint = "/nix/persist-alt";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/snapshots" = {
                      mountpoint = "/.snapshots";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "42G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  fileSystems = {
    "/nix/persist".neededForBoot = true;
    "/nix/persist-alt".neededForBoot = true;
    "/.swapvol".neededForBoot = true;
  };
}
