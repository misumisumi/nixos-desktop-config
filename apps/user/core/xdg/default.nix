{ config, pkgs, ... }:
{
  # xdg系のフォルダの作製
  xdg = {
    enable = true;
    userDirs = {
      enable = pkgs.stdenv.hostPlatform.isLinux;
      createDirectories = true;
      extraConfig = {
        XDG_WORKSPACE_DIR = "${config.home.homeDirectory}/Workspace";
      };
    };
  };
}
