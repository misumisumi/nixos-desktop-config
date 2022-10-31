{ config, lib, user, pkgs, ... }:

{
  home = {
    file."${config.home.homeDirectory}/.background-image".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
  };

  services.xserver.displayManager = {
    defaultSession = "plasma5";
    lightdm.background = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
  };
  services.xserver.desktopManager = {
    plasma5 = {
      enable = true;
      useQtScaling = true;
    };
    wallpaper.mode = "scale";
  };
}
