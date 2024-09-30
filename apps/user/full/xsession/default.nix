/*
  Manage xsession from home-manager.
  NixOS is not manager Keyboard if you use this, so you must manage xkb keyboard from this.
  However, mouse and trackpad are managed from xserver. (conf is ./xserver.nix)
*/
{
  config,
  lib,
  pkgs,
  useNixOSWallpaper ? true,
  ...
}:
{
  home = {
    packages = with pkgs; [
      xclip
      xorg.xev
      xorg.xhost
      xorg.xkill
      xorg.xrandr
    ];
    file =
      lib.optionalAttrs useNixOSWallpaper (
        builtins.listToAttrs (
          map
            (x: {
              name = "${config.home.homeDirectory}/Pictures/wallpapers/${x}";
              value = {
                enable = true;
                source = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
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
      size = lib.mkDefault 24;
    };
  };

  xsession = {
    enable = true;
    preferStatusNotifierItems = true;

    profileExtra = ''
      export SDL_JOYSTICK_HIDAPI=0
      xhost si:localuser:$USER &
    '';
  };
}
