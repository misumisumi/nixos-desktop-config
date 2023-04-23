{
  hostname,
  user,
  pkgs,
  config,
  ...
}: let
  png =
    if hostname != "general"
    then "${config.users.users.${user}.home}/Pictures/wallpapers/background.png"
    else "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
in {
  imports = [../common/xserver.nix];

  services.xserver.displayManager = {
    defaultSession = "none+xsession";
    lightdm.background = png;
  };
}