{
  lib,
  pkgs,
  config,
  getEncryptFile,
  ...
}:
{
  xresources = {
    extraConfig = "Xft.dpi:150";
  };
  xsession.windowManager.command = lib.mkForce ''
    ${pkgs.xrandr}/bin/xrandr --fbmm 6720x3780 --output HDMI-A-1 --pos 0x0 --mode 3840x2160 --scale 1x1 --primary --output DVI-D-0 --pos 3840x0 --mode 1920x1200 --scale 1.5x1.5
    ${config.xsession.windowManager.qtile.finalPackage}/bin/qtile start -b x11
  '';
  home.pointerCursor = {
    size = 32;
  };
  xdg.configFile = {
    "qtile/local_config.py".source = ./qtile/local_config.py;
    "qtile/local_variables.py".source = ./qtile/local_variables.py;
  };
  sops.secrets = {
    "env" = {
      path = "${config.home.homeDirectory}/.env";
      sopsFile = getEncryptFile "pkgs/ai-tools/env";
      format = "binary";
    };
    "univ" = {
      path = "${config.home.homeDirectory}/.ssh/conf.d/hosts/univ";
      sopsFile = getEncryptFile "pkgs/ssh/univ";
      format = "binary";
    };
  };
}
