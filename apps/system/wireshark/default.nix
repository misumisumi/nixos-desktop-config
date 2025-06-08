{ user, ... }:
{
  users.groups = {
    wireshark.members = [
      user
    ];
  };
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
  };
}
