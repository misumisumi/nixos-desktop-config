{
  services.xserver = {
    digimend.enable = true;
    inputClassSection = [
    ''
      Identifier "XP-Pen Artist Pro 16"
      MatchUSBID "28bd:094b"
      MatchIsTablet "on"
      MatchDevicePath "/dev/input/event*"
      Driver "wacom"
    ''
    ''
      Identifier "XP-Pen Artist Pro 16"
      MatchUSBID "28bd:094b"
      MatchIsKeyboard "on"
      MatchDevicePath "/dev/input/event*"
      Driver "libinput"
    ''
    ];
  };
}
