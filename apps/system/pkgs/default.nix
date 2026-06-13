{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      e2fsprogs # Filesystem utils
      nvme-cli
      pciutils # Device utils
      screen # Separate terminal
      smartmontools
      usbutils
    ];
  };
}
