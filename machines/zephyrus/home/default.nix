{ config, getEncryptFile, ... }:
{
  xresources = {
    extraConfig = "Xft.dpi:100";
  };
  xdg.configFile = {
    "qtile/local_config.py".source = ./qtile/local_config.py;
  };
  sops.secrets = {
    "env" = {
      path = "${config.home.homeDirectory}/.env";
      sopsFile = getEncryptFile "pkgs/ai-tools/env";
      format = "binary";
    };
    "desktops" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/desktops";
      sopsFile = getEncryptFile "pkgs/ssh/desktops";
      format = "binary";
    };
    "servers" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/servers";
      sopsFile = getEncryptFile "pkgs/ssh/servers";
      format = "binary";
    };
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = getEncryptFile "pkgs/ssh/univ";
      format = "binary";
    };
  };
}
