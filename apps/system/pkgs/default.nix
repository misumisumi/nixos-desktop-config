{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      pciutils # Device utils
      usbutils
      screen # Separate terminal
    ];
  };
}
