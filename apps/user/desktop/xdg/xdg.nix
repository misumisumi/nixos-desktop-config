{ config, ... }:
{
  # xdg系のフォルダの作製
  xdg.userDirs = {
    extraConfig = {
      XDG_GAME_DIR = "${config.home.homeDirectory}/Game";
    };
  };
}
