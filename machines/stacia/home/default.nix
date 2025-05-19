{ config, ... }:
{
  xresources = {
    extraConfig = "Xft.dpi:100";
  };
  sops.secrets = {
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = ../../../sops/pkgs/ssh/univ;
      format = "binary";
    };
  };
  xdg.configFile = {
    "codecompanion/api-keys.yaml" = {
      source = ../../../sops/pkgs/codecompanion/api-keys.yaml;
    };
  };
}
