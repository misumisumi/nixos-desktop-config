# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config
, lib
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "uas" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
      luks.devices = {
        luksroot = {
          device = "/dev/disk/by-partlabel/LUKSROOT";
          preLVM = true;
          allowDiscards = true;
        };
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/mother-root";
    fsType = "ext4";
  };
  fileSystems."/nix" = {
    device = "/dev/disk/by-label/mother-nix";
    fsType = "ext4";
  };
  fileSystems."/var" = {
    device = "/dev/disk/by-label/mother-var";
    fsType = "ext4";
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-label/mother-home";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/mo-boot";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/dev/mapper/VolGroup00-lvolswap";
      priority = 10;
    }
  ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
