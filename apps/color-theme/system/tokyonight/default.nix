{
  pkgs,
  colorTheme ? "tokyonight-storm",
  ...
}:
let
  flavor = builtins.replaceStrings [ "tokyonight-" ] [ "" ] colorTheme;
in
{
  programs.dconf = {
    enable = true;
    profiles = {
      user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              color-scheme = if flavor == "day" then "prefer-light" else "prefer-dark";
            };
          };
        }
      ];
    };
  };
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
