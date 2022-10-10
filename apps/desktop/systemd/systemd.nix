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
            ExecStart = "scream -i br0 -v";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };

        scream-ivshmem-pulse = {
          Unit = {
            Description = "Scream IVSHMEM pulse receiver";
            After = [ "pulseaudio.service" ];
            Wants = [ "pulseaudio.service" ];
          };
          Service = {
            Type = "simple";
            ExecStartPre = "truncate -s 0 /dev/shm/scream-ivshmem & dd if=/dev/zero of=/dev/shm/scream-ivshmem bs=1M count=2";
            ExecStart = "${pkgs.scream}/bin/scream -m /dev/shm/scream-ivshmem";
          };

        };

        polkit-gnome-authentication-agent-1 = {
          Unit = {
            Description = "polkit-gnome-authentication-agent-1";
            Wants = [ "graphical-session.target" ];
            WantedBy = [ "graphical-session.target" ];
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
            WantedBy = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
          };
          Service = {
            Type = "simple";
            ExecStart = "${pkgs.thunar}/bin/thunar --daemon";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };

      };
    };
  };
}
