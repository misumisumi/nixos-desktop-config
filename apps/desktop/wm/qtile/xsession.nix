/*
Manage xsession from home-manager.
NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/
{
  config,
  lib,
  hostname,
  pkgs,
  ...
}: let
  pyEnv = pkgs.python3.withPackages (p: with pkgs; [qtile-unwrapped.unwrapped or qtile-unwrapped]);
in
  with lib; {
    imports = optional (hostname == "general") ../../../../modules/nixosWallpaper.nix;
    home = {
      packages = with pkgs; [xorg.xmodmap];
    };

    xdg = {
      configFile = {
        "qtile".source = ./conf;
      };
    };

    xsession = {
      putWallpapers.enable = true;
      windowManager = {
        # Not launch using dbus-launch because systemd manage dbus-user-mesage since ver.226
        command = ''
          ${pyEnv}/bin/qtile start
        ''; # You maybe have some probrem (ex fcitx5...) if you launch using it.
      }; # You can see this in ArchWiki https://wiki.archlinux.jp/index.php/Systemd/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC#D-Bus
    };
  }
