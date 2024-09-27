# Auto launch apps
{ config, ... }:
{
  services = {
    blueman-applet.enable = true;
    copyq.enable = true;
    udiskie.enable = true;
    flameshot = {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
          savePath = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}";
          savePathFixed = true;
        };
      };
    };
    kdeconnect = {
      enable = true;
      indicator = true; # launch from qtile
    };
  };
}
