# Auto launch apps
{
  lib,
  pkgs,
  config,
  ...
}:
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
  #BUG: https://bugs.kde.org/show_bug.cgi?id=513536
  #NOTE: 25/01/10: Ver 25.12.1ではログイン毎にBT backendをON→OFFしなければ問題の一時解決も機能しない
  #NOTE: 26/06/11: 依然として修正されていないので、BT backendをdisableする。
  systemd.user.services.kdeconnect.Service.ExecStartPost =
    "${config.services.kdeconnect.package}/bin/kdeconnect-cli --disable-backend BluetoothLinkProvider";
}
