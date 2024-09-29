{
  imports = [ ../xserver ];

  services.xserver.desktopManager = {
    gnome = {
      enable = true;
    };
  };
}
