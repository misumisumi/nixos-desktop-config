{ pkgs, ... }:
{
  imports = [
    ../core/x11
    ../core/apps/nemo
    ../core/apps/pkgs
    ../core/apps/services
    ../core/ime/fcitx5
    ../core/ime/skk
  ];

  xsession.windowManager.qtile = {
    enable = true;
    configSource = ./conf;
    extraPackages = with pkgs.python3.pkgs; [ qtile-extras ];
  };
}
