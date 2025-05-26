{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord # chat
    element-desktop # matrix chat
    slack # chat
    thunderbird-latest-bin
    zoom-us # video conferencing app
  ];
}
