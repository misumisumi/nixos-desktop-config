{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
  ];
  gtk.theme = {
    name = "Tokyonight-Dark";
    package = pkgs.tokyonight-gtk-theme;
  };
}
