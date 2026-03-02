{ pkgs, ... }:
{
  imports = [
    ./looking-glass.nix
  ];
  home.packages = with pkgs; [
    asunder # CD ripper
    baobab # Disk Usage Analyzer
    font-manager # font-manger
    nomacs # Image Viewer
    obsidian # Note taking app
    remmina # Remote desktop client
    simple-scan # Scanner
  ];
}
