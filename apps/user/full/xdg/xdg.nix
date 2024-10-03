{ config, pkgs, ... }:
{
  # xdg系のフォルダの作製
  xdg = {
    userDirs = {
      extraConfig = {
        XDG_GAME_DIR = "${config.home.homeDirectory}/Game";
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      };
    };
  };
}
