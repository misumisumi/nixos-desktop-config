{ config
, lib
, pkgs
, user
, useNixOSWallpaper
, wm
, ...
}: {
  imports = lib.optional (wm != "gnome") ./gsettings.nix;
  users.groups = {
    video.members = [ "${user}" ];
  };
  programs = {
    gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
    light.enable = true;
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
            if useNixOSWallpaper
            then "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}"
            else ./wallpapers/background.png;
          greeters = {
            slick = {
              enable = true;
              draw-user-backgrounds = true;
              cursorTheme = {
                name = "Dracula-cursors";
                package = pkgs.dracula-theme;
                size = lib.mkDefault 24;
              };
              iconTheme = {
                name = "Papirus-Dark";
                package = pkgs.papirus-icon-theme;
              };
              theme = {
                name = "Adapta-Nokto-Eta";
                package = pkgs.adapta-gtk-theme;
              };
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
    xclip
    xorg.xhost
    xorg.xev
    xorg.xkill
    xorg.xrandr
    xterm
  ];
}
