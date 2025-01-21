{ pkgs, ... }:
{
  home.packages = [ pkgs.seahorse ];
  services.gnome-keyring = {
    enable = true;
    components = [
      "secrets"
    ];
  };
}
