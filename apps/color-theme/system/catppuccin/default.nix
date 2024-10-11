{
  lib,
  pkgs,
  colorTheme ? "catppuccin-macchiato",
  ...
}:
let
  flavor = builtins.replaceStrings [ "catppuccin-" ] [ "" ] colorTheme;
  shade = if flavor == "latte" then "Light" else "Dark";
in
{
  services.xserver.displayManager = {
    lightdm = {
      greeters = {
        slick = {
          cursorTheme = {
            name = "catppuccin-${flavor}-${shade}-cursors";
            package = pkgs.catppuccin-cursors.${flavor + shade};
          };
          theme = {
            name = "Catppuccin-GTK-${shade}";
            package = pkgs.magnetic-catppuccin-gtk.override { shade = lib.toLower shade; };
          };
          iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          };
        };
      };
    };
  };
}
