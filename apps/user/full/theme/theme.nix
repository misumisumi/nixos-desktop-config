# Uniformed look for Qt and GTK applications
{ pkgs, ... }:
let
  extraConfig = { };
in
{
  home.pointerCursor.gtk.enable = true;
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans CJK JP";
      package = pkgs.noto-fonts-cjk-sans;
      size = 12;
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
