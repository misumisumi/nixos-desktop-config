{
  imports = [
    ../gsettings
    ../../xserver
  ];
  services.xserver.displayManager = {
    defaultSession = "none+xsession";
  };
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
