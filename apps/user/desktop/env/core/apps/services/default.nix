# Auto launch apps
{
  lib,
  config,
  ...
}:
let
  inherit (lib) hm optionalAttrs;
in
{
  home.activation.mkSnapshotsDirAction = hm.dag.entryAfter [ "writeBoundary" ] ''
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
        }
        // optionalAttrs config.xsession.windowManager.qtile.enable {
          useX11LegacyScreenshot = true;
          captureActiveMonitor = true;
        };
      };
    };
    kdeconnect = {
      enable = true;
      indicator = true; # launch from qtile
    };
  };
}
