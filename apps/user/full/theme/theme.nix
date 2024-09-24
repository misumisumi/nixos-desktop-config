# Uniformed look for Qt and GTK applications
{ pkgs, ... }:
let
  extraConfig = { };
in
{
  imports = [
    ./tokyo-night
  ];
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans CJK JP";
      package = pkgs.noto-fonts-cjk-sans;
      size = 12;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
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
