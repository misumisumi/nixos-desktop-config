{ config
, pkgs
, ...
}: {
  home = {
    packages = with pkgs; [ gnome3.gnome-tweaks ];
  };
}
