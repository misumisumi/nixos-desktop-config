/*
  Manage xsession from home-manager.
  NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
  However, mouse and trackpad are managed from xserver. (conf is apps/system/xserver)
*/
{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      xclip
      xorg.xev
      xorg.xhost
      xorg.xkill
      xorg.xrandr
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
}
