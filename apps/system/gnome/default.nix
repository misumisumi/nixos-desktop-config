{ config
, lib
, user
, pkgs
, ...
}: {
  imports = [ ../xserver ];

  services.xserver.desktopManager = {
    gnome = {
      enable = true;
    };
  };
}
