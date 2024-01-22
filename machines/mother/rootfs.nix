let
  rootDevice = "/dev/disk/by-id/nvme-SPCC_M.2_PCIe_SSD_296E079C18FC00597627";
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
                name = "luksroot";
                extraOpenArgs = [ ];
                passwordFile = "/tmp/secret.key";
                settings.allowDiscards = true;
                additionalKeyFiles = [ ];
                content = {
                  type = "lvm_pv";
                  vg = "VolGroup00";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      VolGroup00 = {
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
            size = "64GB";
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
              # vm.swapiness = 10 due to realtime audio
              type = "swap";
              resumeDevice = true;
            };
          };
        };
      };
    };
  };
}
