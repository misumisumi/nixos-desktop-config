{ pkgs, ... }:
{
  imports = [
    ../core/apps/ime/fcitx5
    ../core/apps/ime/skk
    ../core/apps/nemo
    ../core/apps/pkgs
    ../core/apps/services
    ../core/gnome/auth
    ../core/x11
  ];

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = with pkgs.haskellPackages; [
      monad-logger
    ];
  };
}
