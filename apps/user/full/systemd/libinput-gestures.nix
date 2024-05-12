{ pkgs, ... }:
{
  xdg = {
    configFile = {
      "libinput-gestures.conf".source = ./configs/libinput-gestures.conf;
    };
  };


  systemd.user.services = {
    libinput-gestures = {
      Unit = {
        Description = "Launch libinput-gestures";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
