{ config, ... }:
{
  # xdg系のフォルダの作製
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_WORKSPACE_DIR = "${config.home.homeDirectory}/workspace";
      };
    };
  };
}
