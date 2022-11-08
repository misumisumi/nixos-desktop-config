/*
User level systemd-unit
Please read each description
*/
{ pkgs, ... }:

{
  systemd.user.services = {
    polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    pcmanfm-daemon = {
      Unit = {
        Description = "Start pcmanfm (GUI Filer) daemon mode";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.pcmanfm}/bin/pcmanfm -d";
        Restart = "no";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

  };
}
