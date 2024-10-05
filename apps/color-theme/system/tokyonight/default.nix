{
  pkgs,
  colorTheme ? "tokyonight-storm",
  ...
}:
let
  flavor = builtins.replaceStrings [ "tokyonight-" ] [ "" ] colorTheme;
in
{
  services.xserver.displayManager = {
    lightdm = {
      greeters = {
        slick = {
          cursorTheme = {
            name = "Dracula-cursors";
            package = pkgs.dracula-theme;
          };
          theme =
            let
              shade = if flavor == "day" then "Light" else "Dark";
            in
            {
              name = "Tokyonight-${shade}";
              package = pkgs.tokyonight-gtk-theme;
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
