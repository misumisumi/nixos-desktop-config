{ hostname, pkgs, ... }:
let
  png = if hostname != "general" then "${pkgs.my-wallpapers}/wallpapers/background.png" else "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
in
{
  imports = [ ../common/xserver.nix ];

  services.xserver.displayManager = {
    defaultSession = "none+xsession";
    lightdm.background = png;
  };
}
