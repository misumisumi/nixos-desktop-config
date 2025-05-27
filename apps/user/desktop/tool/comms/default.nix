{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord # chat
    element-desktop # matrix chat
    slack # chat
    zoom-us # video conferencing app
  ];
}
