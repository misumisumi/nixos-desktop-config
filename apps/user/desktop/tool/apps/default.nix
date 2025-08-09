{ pkgs, ... }:
{
  home.packages = with pkgs; [
    asunder # CD ripper
    baobab # Disk Usage Analyzer
    font-manager # font-manger
    looking-glass-client # A KVM Frame Relay (KVMFR) implementation
    nomacs # Image Viewer
    obsidian # Note taking app
    remmina # Remote desktop client
    simple-scan # Scanner
  ];
}
