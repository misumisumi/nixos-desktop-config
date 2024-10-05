{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord # chat
    element-desktop # matrix chat
    ferdium # One place, Some webapp
    slack # chat
    zoom-us # video conferencing app
  ];
}
