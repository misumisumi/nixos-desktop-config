{ pkgs, user, ... }:
{
  users.groups = {
    wireshark.members = [
      user
    ];
  };
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
    usbmon.enable = true;
  };
}
