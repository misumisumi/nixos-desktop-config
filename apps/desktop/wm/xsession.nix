{ config, lib, user, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ qtile ];
    file."${config.home.homeDirectory}/Pictures/wallpapers".source = ./qtile/wallpapers;
    keyboard = {
      layout = "us";
      model = "pc104";
      options = [ "ctrl:nocaps" ];
    };
    pointerCursor = {
      name = "Capitaine Cursors";
      package = pkgs.capitaine-cursors;
    };

  };

  xdg = {
    configFile = {
      "qtile".source = ./qtile;
    };
  };
  xresources.extraConfig = ''
    Xft.dpi: 110
  '';

  xsession = {
    enable = true;

    windowManager = {
      command = "${pkgs.qtile}/bin/qtile start";
    };
    
    preferStatusNotifierItems = true;

    profileExtra=''
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS=@im=fcitx
      export GLFW_IM_MODULE=ibus
      export QT_STYLE_OVERRIDE=gtk2
      export XDG_CONFIG_HOME=~/.config
      export SDL_JOYSTICK_HIDAPI=0
      xhost si:localuser:$USER &
      # if [ $(hostname) = "zephyrus" ]; then
      #     asusctltray &
      # fi
    '';
  };
}
