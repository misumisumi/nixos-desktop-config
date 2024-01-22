{
  imports = [ ../../xserver ];
  services.xserver.displayManager = {
    defaultSession = "none+xsession";
  };
}
