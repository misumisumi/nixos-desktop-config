{ pkgs, ... }:
{
  imports = [
    ../core/apps/nemo
    ../core/apps/pkgs
    ../core/apps/services
    ../core/gnome
    ../core/ime/fcitx5
    ../core/ime/skk
    ../core/x11
  ];

  xsession.windowManager.qtile = {
    enable = true;
    configSource = ./conf;
    extraPackages = with pkgs.python3Packages; [
      qtile-extras
    ];
  };
}
