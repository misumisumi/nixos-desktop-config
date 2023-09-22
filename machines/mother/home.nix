{ pkgs, ... }:
{
  imports = [
    ../common/home.nix
  ];
  home.packages = with pkgs; [ prime-run bt-dualboot xp-pen-driver ];
  xresources = {
    extraConfig = "Xft.dpi:120";
  };
}
