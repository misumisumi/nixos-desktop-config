# Auto launch apps
{ wm, ... }: {
  services = {
    udiskie.enable = true;

    blueman-applet.enable = true;

    flameshot.enable = true;

    kdeconnect = {
      enable = true;
      indicator = wm != "qtile"; # launch from qtile
    };
  };
}
