/*
Manage xsession from home-manager.
NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/

{ config, lib, user, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ qtile libinput-gestures ];
    file."${config.home.homeDirectory}/Pictures/wallpapers".source = ./qtile/wallpapers;
    keyboard = {
      layout = "us";
      model = "pc104";
      options = [ "ctrl:nocaps" ];
    };
    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 32;
    };

  };

  xdg = {
    configFile = {
      "qtile".source = ./qtile;
      "libinput-gestures.conf".source = ./libinput-gestures.conf;
    };
  };
  xresources.properties = {
    "Xft.dpi" = 110;
  };

  xsession = {
    enable = true;
    preferStatusNotifierItems = true;

    windowManager = {             # Not launch using dbus-launch because systemd manage dbus-user-mesage since ver.226
      command = "qtile start";    # You maybe have some probrem (ex fcitx5...) if you launch using it.
    };                            # You can see this in ArchWiki https://wiki.archlinux.jp/index.php/Systemd/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC#D-Bus

    profileExtra = ''
      export GLFW_IM_MODULE=ibus
      export SDL_JOYSTICK_HIDAPI=0
      xhost si:localuser:$USER &
      # if [ $(hostname) = "zephyrus" ]; then
      #     asusctltray &
      # fi
    '';
  };

  systemd.user.services = {
    libinput-gestures = {
      Unit = {
        Description = "Launch libinput-gestures";
        Partof = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
