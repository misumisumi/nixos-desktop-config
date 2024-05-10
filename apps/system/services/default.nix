{ pkgs, ... }:
{
  imports = [ ./interception-tools.nix ];
  services = {
    blueman.enable = true;
    udisks2.enable = true;
    dbus.packages = with pkgs; [ xfce.xfconf ];
    gvfs.enable = true; # Mount, trash, and other functions
    tumbler.enable = true; # Thumbnail supoport for images
  };
}
