{ config, lib, user, pkgs, ... }:

{
  imports = [ ../common/xserver.nix ];

  services.xserver.displayManager = {
    defaultSession = "plasma";
    lightdm.background = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
  };
  services.xserver.desktopManager = {
    plasma5 = {
      enable = true;
      useQtScaling = true;
    };
  };
}
