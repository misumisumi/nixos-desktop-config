/*
Manage xsession from home-manager.
NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/

{ config, lib, user, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ qtile libinput-gestures ];
    file."${config.home.homeDirectory}/Pictures/wallpapers".source = ./conf/wallpapers;
  };

  xdg = {
    configFile = {
      "qtile".source = ./conf;
      "libinput-gestures.conf".source = ./libinput-gestures.conf;
    };
  };
  xsession = {
    windowManager = {             # Not launch using dbus-launch because systemd manage dbus-user-mesage since ver.226
      command = "qtile start";    # You maybe have some probrem (ex fcitx5...) if you launch using it.
    };                            # You can see this in ArchWiki https://wiki.archlinux.jp/index.php/Systemd/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC#D-Bus
  };
}
