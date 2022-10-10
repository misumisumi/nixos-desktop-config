{ conifg, lib, user, pkgs, ... }:
let
  userDir = "/home/${user}";
in
{
  xsession = {
    enable = true;

    windowManager = {
      command = "${pkgs.qtile}/bin/qtile start -c ${userDir}/.dotfiles/apps/desktop/wm/qtile/config.py ";
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
      thunar --daemon &
      if [ $(hostname) = "zephyrus" ]; then
          asusctltray &
      fi
    '';
  };

  xresources = {
    extraConfig = "Xft.dpi:110";
  };

}
