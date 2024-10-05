{ pkgs, ... }:
{
  services.xserver.displayManager = {
    lightdm = {
      greeters = {
        slick = {
          cursorTheme = {
            name = "Nordzy-cursors";
            package = pkgs.nordzy-cursor-theme;
          };
          theme = {
            name = "Nordic-darker";
            package = pkgs.nordic;
          };
          iconTheme = {
            name = "Nordzy-dark";
            package = pkgs.nordzy-icon-theme;
          };
        };
      };
    };
  };
}
