{ config, getEncryptFile, ... }:
{
  xresources = {
    extraConfig = "Xft.dpi:125";
  };
  home.pointerCursor = {
    size = 32;
  };
  xdg.configFile = {
    "qtile/local_variables.py".source = ./qtile/local_variables.py;
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
    "homelab" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/homelab";
      sopsFile = getEncryptFile "pkgs/ssh/homelab";
      format = "binary";
    };
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = getEncryptFile "pkgs/ssh/univ";
      format = "binary";
    };
  };
}
