/*
Auto launch apps
*/
{ config, hostname, pkgs, ... }:

{
  services = {
    udiskie.enable = true;

    blueman-applet.enable = true;

    flameshot.enable = true;

    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}

