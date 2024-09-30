{
  config,
  lib,
  pkgs,
  useNixOSWallpaper,
  ...
}:
{
  home = {
    packages = with pkgs; [
      betterlockscreen
      xorg.xrdb
    ];
    file =
      lib.optionalAttrs useNixOSWallpaper (
        builtins.listToAttrs (
          map
            (x: {
              name = "${config.home.homeDirectory}/Pictures/wallpapers/${x}";
              value = {
                enable = true;
                source = pkgs.nixos-artwork.wallpapers.catppuccin-mocha.gnomeFilePath;
              };
            })
            [
              "fixed/00_main.png"
              "unfixed/00_main.png"
              "background.png"
              "screen_saver.png"
            ]
        )
      )
      // lib.optionalAttrs (!useNixOSWallpaper) {
        wallpapers = {
          source = ./wallpapers;
          target = "${config.xdg.userDirs.pictures}/wallpapers";
          recursive = true;
        };
      };
  };
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

    Install = {
      WantedBy = [ " graphical-session.target " ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${config.services.betterlockscreen.package}/bin/betterlockscreen -u ${config.xdg.userDirs.pictures}/wallpapers/screen_saver.png";
    };
  };
}
