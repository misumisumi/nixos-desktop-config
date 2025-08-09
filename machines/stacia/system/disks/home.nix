let
  device = "/dev/disk/by-id/ata-WDC_WDS100T2B0A-00SM50_2012A4445212";
in
{
  disko.devices = {
    disk = {
      home = {
        type = "disk";
        inherit device;
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              label = "LUKSROOT";
              content = {
                type = "luks";
                name = "lukshome";
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
                      mountpoint = "/.swapfile";
                      swap.swapfile.size = "32G";
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
}
