{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
  ];

  programs.feh.enable = true;
}
