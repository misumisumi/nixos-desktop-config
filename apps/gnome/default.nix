{ config
, lib
, user
, pkgs
, ...
}: {
  imports = [ ../xserver ];

  services.xserver.displayManager = {
    lightdm.background = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
  };
  services.xserver.desktopManager = {
    gnome = {
      enable = true;
    };
  };
}
