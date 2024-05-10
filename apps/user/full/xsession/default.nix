/*
  Manage xsession from home-manager.
  NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
  However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/
{ config
, lib
, user
, pkgs
, useNixOSWallpaper ? true
, ...
}: {
  services = {
    screen-locker.xautolock.enable = true;
    betterlockscreen = {
      enable = true;
      inactiveInterval = 40;
      arguments = [ "--show-layout" ];
    };
  };
  systemd.user.services.betterlockscreen-update = {
    Unit = {
      Description = "";
      After = [ "graphical-session.target" ];
    };

    Install = { WantedBy = [ " graphical-session.target " ]; };

    Service = {
      Type = "oneshot";
      ExecStart = "${config.services.betterlockscreen.package}/bin/betterlockscreen -u ${config.home.homeDirectory}/Pictures/wallpapers/screen_saver.png";
    };
  };

  home = {
    packages = with pkgs; [ betterlockscreen ];
    file = lib.optionalAttrs useNixOSWallpaper
      (builtins.listToAttrs
        (map
          (x: {
            name = "${config.home.homeDirectory}/Pictures/wallpapers/${x}";
            value = {
              enable = true;
              source = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
            };
          }) [
          "fixed/0_main.png"
          "fixed/1_main.png"
          "unfixed/main.png"
          "background.png"
          "screen_saver.png"
        ])
      )
    //
    lib.optionalAttrs (!useNixOSWallpaper) (lib.mapAttrs'
      (f: _:
        lib.nameValuePair "${config.home.homeDirectory}/Pictures/wallpapers/${f}" {
          enable = true;
          source = ./wallpapers/${f};
        })
      (builtins.readDir ./wallpapers));
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    keyboard = {
      layout = "us";
      model = "pc104";
      options = [ "ctrl:nocaps" ];
    };
    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = lib.mkDefault 24;
    };
  };

  xsession = {
    enable = true;
    preferStatusNotifierItems = true;

    profileExtra = ''
      export GLFW_IM_MODULE=ibus
      export SDL_JOYSTICK_HIDAPI=0
      xhost si:localuser:$USER &
    '';
  };
}

