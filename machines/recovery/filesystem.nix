{ lib, ... }:
let
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
            lvm-recovery = {
              size = "100%";
              type = "8E00";
              content = {
                type = "lvm_pv";
                vg = "lvm-recovery";
              };
            };
            luks-recovery = {
              size = "32G";
              content = {
                type = "luks";
                name = "crypted-recovery";
                extraOpenArgs = [ ];
                settings = {
                  # if you want to use the key for interactive login be sure there is no trailing newline
                  # for example use `echo -n "password" > /tmp/secret.key`
                  keyFile = "/tmp/secrets/luks.key";
                  allowDiscards = true;
                };
                # additionalKeyFiles = [ "/tmp/secrets/additionalSecret.key" ];
                content = {
                  type = "lvm_pv";
                  vg = "secrets-recovery";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      lvm-recovery = {
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
      secrets-recovery = {
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
