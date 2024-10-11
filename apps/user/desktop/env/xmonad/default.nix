{ pkgs, ... }:
{
  imports = [
    ../core/x11
    ../core/apps/nemo
    ../core/apps/pkgs
    ../core/apps/services
    ../core/apps/ime/fcitx5
    ../core/apps/ime/skk
  ];

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = with pkgs.haskellPackages; [
      monad-logger
    ];
  };
}
