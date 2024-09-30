/*
  Manage xsession from home-manager.
  NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
  However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/
{ pkgs, ... }:
{
  home.packages = with pkgs; [ xorg.xmodmap ];
  systemd.user.targets.tray.Unit.ExecPost = "${pkgs.coreutils}/bin/sleep 3";

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gnome
      ];
      configPackages = with pkgs; [ gnome-session ];
    };
    configFile.qtile = {
      source = ./conf;
      target = "qtile";
      recursive = true;
    };
  };

  xsession = {
    windowManager = {
      # Not launch using dbus-launch because systemd manage dbus-user-message since ver.226
      command =
        let
          qtile = pkgs.python3.pkgs.qtile.override {
            extraPackages = with pkgs.python3.pkgs; [ qtile-extras ];
          };
        in
        ''
          ${qtile}/bin/qtile start -b x11
        ''; # You maybe have some probrem (ex fcitx5...) if you launch using it.
    }; # You can see this in ArchWiki https://wiki.archlinux.jp/index.php/Systemd/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC#D-Bus
  };
}
