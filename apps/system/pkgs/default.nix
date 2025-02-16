{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      nvme-cli
      pciutils # Device utils
      screen # Separate terminal
      smartmontools
      usbutils
    ];
  };
}
