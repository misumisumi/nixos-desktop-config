# This is "NixOS" options.
{ pkgs, ... }:

{
  hardware.steam-hardware.enable = false;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
}
