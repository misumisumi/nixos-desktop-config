{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
  ];
  gtk.theme = {
    name = "Nordic-darker";
    package = pkgs.nordic;
  };
  home.pointerCursor = {
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
  };
  services.dunst.settings.global.frame_color = "#02adc7";
}
