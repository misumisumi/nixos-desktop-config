/*
Manage xsession from home-manager.
NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/
{ config, lib, hostname, pkgs, ... }:
let
  use_my = if hostname != "general" then true else false;
  use_private_module = if use_my then [] else [ ./nixosWallpaper.nix ];
in
{
  imports = use_private_module;
  home = {
    packages = with pkgs; [ qtile libinput-gestures ];
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
}
