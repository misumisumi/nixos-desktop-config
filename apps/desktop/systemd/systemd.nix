/*
User level systemd-unit
Please read each description
*/
{ pkgs, ... }:

{
  systemd = {
    user = {
      services = {
        scream = {
          Unit = {
            Description = "Scream Receiver (For windows VM)";
            After = [ "network-online.target" "pulseaudio.service" ];
          };
          Service = {
            Type = "simple";
            ExecStart = "${pkgs.scream}/bin/scream -i br0 -v";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };

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
        };

        thunar-daemon = {
          Unit = {
            Description = "Start thunar (GUI Filer) daemon mode";
            After = [ "graphical-session.target" ];
          };
          Service = {
            Type = "simple";
            ExecStart = "${pkgs.xfce.thunar}/bin/thunar --daemon";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };
      };
    };
  };
}
