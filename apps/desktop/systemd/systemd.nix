{ pkgs, ... }:

{
  systemd = {
    user = {
      services = {
        scream = {
          Unit = {
            Description = "Scream Receiver";
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
            Wants = [ "graphical-session.target" ];
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
            Description = "Start thunar daemon mode";
            Wants = [ "graphical-session.target" ];
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
