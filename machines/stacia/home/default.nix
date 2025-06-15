{ config, ... }:
{
  xresources = {
    extraConfig = "Xft.dpi:100";
  };
  xdg.configFile = {
    "codecompanion/api-keys.yaml".source = ../../../sops/pkgs/codecompanion/api-keys.yaml;
    "qtile/local_config.py".source = ./qtile/local_config.py;
  };
  sops.secrets = {
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = ../../../sops/pkgs/ssh/univ;
      format = "binary";
    };
  };
}
