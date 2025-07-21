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
    package = pkgs.qtile-unwrapped.overrideAttrs (old: {
      patches = old.patches ++ [ ../../../../../patches/qtile.patch ];
    });
    extraPackages = with pkgs.python3Packages; [
      qtile-extras
    ];
  };
}
