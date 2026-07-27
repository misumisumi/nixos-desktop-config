{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      xclip
      xev
      xhost
      xkill
      xrandr
      xrdb
    ];
    keyboard = {
      layout = "us";
      model = "pc104";
      options = [ "ctrl:nocaps" ];
    };
    pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      size = lib.mkDefault 24;
    };
  };

  xsession = {
    enable = true;
    preferStatusNotifierItems = true;

    profileExtra = ''
      export SDL_JOYSTICK_HIDAPI=0
      xhost si:localuser:$USER &
    '';
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
