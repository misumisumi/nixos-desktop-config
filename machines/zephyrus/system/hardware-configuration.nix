{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../init/zfs.nix
  ];
  networking.hostId = "dade0dc9"; # for zfs
  boot = {
    supportedFilesystems = [ "ntfs" ];
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usbhid"
        "usb_storage"
        "uas"
        "sd_mod"
      ];
    };
    kernelParams = [
      "amd_pstate=active"
    ];
  };
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  systemd.tmpfiles.rules = [
    # increase the speed of resuming a hibernating system
    "w    /sys/power/image_size - - - - 0"
  ];
}
