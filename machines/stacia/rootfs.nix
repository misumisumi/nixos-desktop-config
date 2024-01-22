let
  rootDevice = "/dev/disk/by-id/ata-WDC_WDS100T2B0A-00SM50_2012A4445212";
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
              size = "256M";
              type = "EF00";
              label = "EFIBoot";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            luks = {
              size = "100%";
              label = "LUKSROOT";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                passwordFile = "/tmp/secret.key";
                settings.allowDiscards = true;
                additionalKeyFiles = [ ];
                content = {
                  type = "lvm_pv";
                  vg = "VolGroupStacia";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      VolGroupStacia = {
        type = "lvm_vg";
        lvs = {
          lvolroot = {
            size = "4GB";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
          lvolhome = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
          lvolvar = {
            size = "96GB";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/var";
            };
          };
          lvolnix = {
            size = "256GB";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
          lvolswap = {
            size = "16GB";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
        };
      };
    };
  };
}
