{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      xclip
      xorg.xev
      xorg.xhost
      xorg.xkill
      xorg.xrandr
      xorg.xrdb
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    keyboard = {
      layout = "us";
      model = "pc104";
      options = [ "ctrl:nocaps" ];
    };
    pointerCursor = {
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
