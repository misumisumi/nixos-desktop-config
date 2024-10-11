let
  root_device = "/dev/disk/by-id/ata-TOSHIBA_MQ01ABF050_76C4P16JT";
  root_device_size = 465.8; # GB
  home_device = "/dev/disk/by-id/ata-WDC_WD40EZRZ-00GXCB0_WD-WCC7K5DFP3YA";
  home_device_size = 3726; # GB
  reserved_size = device_size: device_size * (1 - 0.89);
in
{
  disko.devices = {
    disk = {
      root = {
        type = "disk";
        device = root_device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "256M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "PoolRootFS";
              };
            };
          };
        };
      };
      home = {
        type = "disk";
        device = home_device;
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "PoolHomeFS";
              };
            };
          };
        };
      };
    };
    zpool = {
      PoolHomeFS = {
        type = "zpool";
        rootFsOptions = {
          "com.sun:auto-snapshot" = "false";
          acltype = "posixacl";
          atime = "on";
          canmount = "off";
          compression = "zstd";
          dnodesize = "auto";
          relatime = "on";
          xattr = "sa";
        };
        datasets = {
          reserved = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              canmount = "off";
              quota = "${builtins.toString (reserved_size home_device_size)}G";
              reservation = "${builtins.toString (reserved_size home_device_size)}G";
            };
          };
          user = {
            type = "zfs_fs";
            options = {
              canmount = "off";
              "com.sun:auto-snapshot" = "true";
            };
          };
          "user/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options.mountpoint = "legacy";
          };
        };
      };
      PoolRootFS = {
        type = "zpool";
        rootFsOptions = {
          "com.sun:auto-snapshot" = "false";
          acltype = "posixacl";
          atime = "on";
          canmount = "off";
          compression = "zstd";
          dnodesize = "auto";
          relatime = "on";
          xattr = "sa";
        };
        datasets = {
          reserved = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              canmount = "off";
              quota = "${builtins.toString (reserved_size root_device_size)}G";
              reservation = "${builtins.toString (reserved_size root_device_size)}G";
            };
          };
          system = {
            type = "zfs_fs";
            options = {
              canmount = "off";
              "com.sun:auto-snapshot" = "false";
            };
          };
          "system/root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options."com.sun:auto-snapshot" = "false";
          };
          "system/var" = {
            type = "zfs_fs";
            mountpoint = "/var";
            options."com.sun:auto-snapshot" = "false";
          };
          "system/var/lib" = {
            type = "zfs_fs";
            mountpoint = "/var/lib";
            options."com.sun:auto-snapshot" = "false";
          };
          local = {
            type = "zfs_fs";
            options = {
              canmount = "off";
              "com.sun:auto-snapshot" = "false";
            };
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
        };
      };
    };
  };
}
