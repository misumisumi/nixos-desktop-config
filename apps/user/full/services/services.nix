# Auto launch apps
{
  services = {
    blueman-applet.enable = true;
    copyq.enable = true;
    flameshot.enable = true;
    udiskie.enable = true;

    kdeconnect = {
      enable = true;
      indicator = true; # launch from qtile
      # indicator = wm != "qtile"; # launch from qtile
    };
  };
}
