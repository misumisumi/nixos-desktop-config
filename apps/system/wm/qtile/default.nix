{
  imports = [ ../../xserver ];
  services.displayManager.defaultSession = "none+xsession";
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
