let
  # write device name here
  device = "/dev/disk/by-id/usb-SAMSUNG_MZALQ128HBHQ_DD56419883ED9-0:0";
in
{
  disko.devices = {
    disk = {
      root = {
        inherit device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            recovery = {
              size = "100%";
              type = "8E00";
              content = {
                type = "lvm_pv";
                vg = "BootUSB";
              };
            };
            luks = {
              size = "32G";
              content = {
                type = "luks";
                name = "luks-bootusb";
                initrdUnlock = false; # Do not unlock on boot
                passwordFile = "/tmp/luks.key";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "SecretUSB";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      BootUSB = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "4G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
          nix = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
          home = {
            size = "16G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
        };
      };
      SecretUSB = {
        type = "lvm_vg";
        lvs = {
          secrets = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
            };
          };
        };
      };
    };
  };
}
