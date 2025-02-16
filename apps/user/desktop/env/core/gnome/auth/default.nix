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
  };
}
