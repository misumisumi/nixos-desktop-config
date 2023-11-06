{ pkgs, ... }:
with pkgs; [
  pciutils # Device utils
  usbutils
  screen # Separate terminal
]
