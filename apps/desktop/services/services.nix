/*
Auto launch apps
*/
{ config, hostname, pkgs, ... }:

{
  services = {
    screen-locker = {
      enable = true;
      inactiveInterval = 40;
      lockCmd = "${pkgs.i3lock}/bin/i3lock -n -t -i ${config.home.homeDirectory}/Pictures/wallpapers/screen_saver.png";

      xautolock = {
        enable = true;
      };
    };

    udiskie.enable = true;

    blueman-applet.enable = true;

    flameshot.enable = true;

    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}

