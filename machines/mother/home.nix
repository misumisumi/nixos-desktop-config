{ config, ... }:
{
  xresources = {
    extraConfig = "Xft.dpi:125";
  };
  # home.pointerCursor = {
  #   size = 32;
  # };
  sops.secrets = {
    "desktops" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/desktops";
      sopsFile = ../../sops/user/ssh/desktops;
      format = "binary";
    };
    "servers" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/servers";
      sopsFile = ../../sops/user/ssh/servers;
      format = "binary";
    };
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = ../../sops/user/ssh/univ;
      format = "binary";
    };
  };
}
