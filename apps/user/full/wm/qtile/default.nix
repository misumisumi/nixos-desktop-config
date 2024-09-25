/*
  Manage xsession from home-manager.
  NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
  However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/
{
  lib,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [ xorg.xmodmap ];
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gnome
      ];
      configPackages = with pkgs; [ gnome-session ];
    };
    configFile =
      (lib.mapAttrs' (
        f: _:
        lib.nameValuePair "qtile/${f}" {
          enable = true;
          source = ./conf/${f};
        }
      ) (lib.filterAttrs (_: t: t == "regular") (builtins.readDir ./conf)))
      // (lib.mapAttrs' (
        f: _:
        lib.nameValuePair "qtile/my_modules/${f}" {
          enable = true;
          source = ./conf/my_modules/${f};
        }
      ) (lib.filterAttrs (_: t: t == "regular") (builtins.readDir ./conf/my_modules)));
  };

  xsession = {
    windowManager = {
      # Not launch using dbus-launch because systemd manage dbus-user-message since ver.226
      command =
        let
          qtile = pkgs.python3.pkgs.qtile.override {
            extraPackages = with pkgs.python3.pkgs; [
              qtile-extras
            ];
          };
        in
        ''
          ${qtile}/bin/qtile start -b x11
        ''; # You maybe have some probrem (ex fcitx5...) if you launch using it.
    }; # You can see this in ArchWiki https://wiki.archlinux.jp/index.php/Systemd/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC#D-Bus
  };
}
