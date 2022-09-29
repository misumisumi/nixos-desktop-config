{ conifg, lib, pkgs, ... }:
let
  userDir = ( import ../../../machines/home.nix ).home.homeDirectory;
in
{
  imports = [
    ../../apps/system
  ];

  xsession = {
    enable = true;
    windowManager.command = "${pkgs.qtile}/bin/qtile start -c ${userDir}/.dotfiles/apps/desktop/wm/qtile/config.py ";
  };

}
