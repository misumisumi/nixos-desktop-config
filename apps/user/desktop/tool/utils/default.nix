{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mesa-demos # OpenGL utility
    nvtopPackages.full # htop like GPU monitor
    vulkan-tools # vulkan utility
  ];
  # monitoring FPS tool
  programs.mangohud.enable = true;
}
