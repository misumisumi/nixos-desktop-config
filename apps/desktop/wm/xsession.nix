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

    windowManager = {
      command = "exec ${pkgs.dbus}/bin/dbus-launch qtile start";
    };

    profileExtra=''
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS=@im=fcitx
      export GLFW_IM_MODULE=ibus
      export SDL_JOYSTICK_HIDAPI=0
      xhost si:localuser:$USER &
      libinput-gestures &
      # if [ $(hostname) = "zephyrus" ]; then
      #     asusctltray &
      # fi
    '';
  };
}
