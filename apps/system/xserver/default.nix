{
  lib,
  pkgs,
  user,
  useNixOSWallpaper,
  config,
  ...
}:
{
  users.groups = {
    video.members = [ "${user}" ];
  };
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  security.pam.services = {
    i3lock.enable = true;
    login.enableGnomeKeyring = true;
    passwd.enableGnomeKeyring = true;
  };

  services = {
    libinput = {
      enable = true;
      mouse.naturalScrolling = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        accelSpeed = "0.6";
      };
    };
    xserver = {
      enable = true;
      autorun = true;
      xkb = {
        layout = "us";
        options = "caps:nocaps"; # keyboard is managed home-manager
      };

      displayManager = {
        lightdm = {
          enable = true;
          background =
            if useNixOSWallpaper then
              "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}"
            else
              ./wallpapers/background.png;
          greeters = {
            slick = {
              enable = true;
              draw-user-backgrounds = true;
              cursorTheme.size = lib.mkDefault 24;
            };
          };
        };
        sessionCommands = ''
          ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all # for keyring
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
}
