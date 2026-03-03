{ config, ... }:
{
  # xdg系のフォルダの作製
  xdg.userDirs = {
    extraConfig = {
      GAME = "${config.home.homeDirectory}/Game";
    };
  };
}
