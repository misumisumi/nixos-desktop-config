/*
  Keyboard is not managed from xserver.
  You must edit home.xsession.keyboard. (conf is ./xsession.nix)
*/
{ config
, lib
, pkgs
, ...
}: {
  programs.light.enable = true;

  services = {
    xserver = {
      enable = true;
      autorun = true;
      gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

      layout = "us";
      xkbOptions = "caps:nocaps"; # keyboard is managed home-manager

      libinput = {
        enable = true;
        mouse.naturalScrolling = true;
        touchpad = {
          tapping = true;
          naturalScrolling = true;
          accelSpeed = "0.6";
        };
      };

      displayManager = {
        lightdm = {
          enable = true;
          greeters = {
            slick = {
              enable = true;
              draw-user-backgrounds = true;
              iconTheme = {
                name = "Papirus-Dark";
                package = pkgs.papirus-icon-theme;
              };
              theme = {
                name = "Adapta-Nokto-Eta";
                package = pkgs.adapta-gtk-theme;
              };
              extraConfig = ''
                xft-dpi = 110
              '';
            };
          };
        };
        sessionCommands = ''
          # ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        '';
        session = [
          {
            manage = "window";
            name = "xsession";
            start = ''
              ${pkgs.runtimeShell} $HOME/.xsession &
              waitPID=$!
            '';
          }
        ];
      };

      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    udevil
    xclip
    xorg.xhost
    xorg.xev
    xorg.xkill
    xorg.xrandr
    xterm
  ];
}
