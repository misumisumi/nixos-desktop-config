{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
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
  };
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  systemd.tmpfiles.rules = [
    # increase the speed of resuming a hibernating system
    "w    /sys/power/image_size - - - - 0"
  ];
}
