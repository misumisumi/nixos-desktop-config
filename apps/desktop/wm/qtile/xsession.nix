/*
Manage xsession from home-manager.
NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/
{ config, lib, hostname, pkgs, ... }:
with lib; 
let
  cfg = config.home.nixosWallpapers;
  use_my = if hostname != "general" then true else false;
in
{
  home = {
    packages = with pkgs; [ qtile libinput-gestures ];
    nixosWallpapers = use_my == false;
  };

  xdg = {
    configFile = {
      "qtile".source = ./conf;
    };
  };
  xsession = {
    putWallpapers.enable = use_my;
    windowManager = {             # Not launch using dbus-launch because systemd manage dbus-user-mesage since ver.226
      command = "qtile start";    # You maybe have some probrem (ex fcitx5...) if you launch using it.
    };                            # You can see this in ArchWiki https://wiki.archlinux.jp/index.php/Systemd/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC#D-Bus
  };

  options = {
    home.nixosWallpapers = mkEnableOption ''
        Get wallpaper from nixos-artwork.
      '';
  };
  config = mkIf cfg.nixosWallpapers {
    home = {
      file."${config.home.homeDirectory}/Pictures/wallpapers/fixed/0_main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
      file."${config.home.homeDirectory}/Pictures/wallpapers/fixed/1_main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
      file."${config.home.homeDirectory}/Pictures/wallpapers/unfixed/main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
    };
  };
}
