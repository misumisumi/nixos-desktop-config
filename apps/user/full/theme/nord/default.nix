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
}
