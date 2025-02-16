{ config, ... }:
{
  xresources = {
    extraConfig = "Xft.dpi:125";
  };
  home.pointerCursor = {
    size = 32;
  };
  sops.secrets = {
    "desktops" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/desktops";
      sopsFile = ../../sops/pkgs/ssh/desktops;
      format = "binary";
    };
    "servers" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/servers";
      sopsFile = ../../sops/pkgs/ssh/servers;
      format = "binary";
    };
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = ../../sops/pkgs/ssh/univ;
      format = "binary";
    };
  };
}
