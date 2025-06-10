{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mesa-demos # OpenGL utility
    vulkan-tools # vulkan utility
  ];
  # monitoring FPS tool
  programs.mangohud.enable = true;
}
