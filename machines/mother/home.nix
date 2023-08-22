{ pkgs, ... }:
{
  imports = [
    ../common/home.nix
  ];
  home.packages = with pkgs; [ prime-run bt-dualboot ];
  xresources = {
    extraConfig = "Xft.dpi:100";
  };
}
