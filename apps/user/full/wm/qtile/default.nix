{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl # CLI control media
    i3lock # Screen Locker
  ];
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
    ];
    configPackages = with pkgs; [ gnome-session ];
  };

  xsession.windowManager.qtile = {
    enable = true;
    configSource = ./conf;
    extraPackages = with pkgs.python3.pkgs; [ qtile-extras ];
  };
}
