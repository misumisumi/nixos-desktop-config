{ config, pkgs, ... }:
{
  # xdg系のフォルダの作製
  xdg = {
    enable = true;
    userDirs = {
      enable = pkgs.stdenv.hostPlatform.isLinux;
      createDirectories = true;
      setSessionVariables = true;
      extraConfig = {
        WORKSPACE = "${config.home.homeDirectory}/Workspace";
      };
    };
  };
}
