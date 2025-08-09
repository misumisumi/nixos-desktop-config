# Auto launch apps
{ lib, config, ... }:
{
  home.activation.mkSnapshotsDirAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    [ -d ${config.xdg.userDirs.pictures}/Screenshots ] || mkdir -p ${config.xdg.userDirs.pictures}/Screenshots
  '';
  services = {
    blueman-applet.enable = true;
    copyq.enable = true;
    udiskie.enable = true;
    flameshot = {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
          savePath = "${config.xdg.userDirs.pictures}/Screenshots";
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
