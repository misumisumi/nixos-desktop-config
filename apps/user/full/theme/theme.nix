# Uniformed look for Qt and GTK applications
{ pkgs, ... }:
let
  extraConfig = { };
in
{
  gtk = {
    enable = true;
    font = {
      # name = "Noto Sans CJK JP";
      # package = pkgs.noto-fonts-cjk-sans;
      # size = 12;
      name = "Source Han Sans"; # Discord have CJK character render problem if you use Noto Font CJK. (https://github.com/NixOS/nixpkgs/issues/171976)
      package = pkgs.source-han-sans;
      size = 12;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adapta-Nokto-Eta";
      package = pkgs.adapta-gtk-theme;
    };
    gtk3.extraConfig = extraConfig;
    gtk4.extraConfig = extraConfig;
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
    };
  };
}
