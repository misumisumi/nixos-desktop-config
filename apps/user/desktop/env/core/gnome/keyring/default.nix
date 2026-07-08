{ pkgs, config, ... }:
{
  home.packages = [ pkgs.seahorse ];
  xdg.portal.extraPortals = [ config.services.gnome-keyring.package ];
  services.gnome-keyring = {
    enable = true;
    components = [
      "secrets"
    ];
  };
}
