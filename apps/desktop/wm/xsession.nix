{ config, lib, user, pkgs, ... }:

{
  xsession = {
    enable = true;

    windowManager = {
      # command = "${pkgs.qtile}/bin/qtile start -c ${config.home.homeDirectory}/nix-config/apps/desktop/wm/qtile/config.py ";
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };

    initExtra = ''
      exec dbus-launch qtile
    '';

    profileExtra=''
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS=@im=fcitx
      export GLFW_IM_MODULE=ibus
      export QT_STYLE_OVERRIDE=gtk2
      export XDG_CONFIG_HOME=~/.config
      export SDL_JOYSTICK_HIDAPI=0
      xhost si:localuser:$USER &
      devmon &
      if [ $(hostname) = "zephyrus" ]; then
          asusctltray &
      fi
    '';
  };

  xresources = {
    extraConfig = "Xft.dpi:110";
  };

}
