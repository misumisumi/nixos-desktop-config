{ config, lib, pkgs, ... }:

{
  programs.light.enable = true;

  services = {
    xserver = {
      enable = true;
      autorun = true;
      gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

      layout = "us";
      xkbOptions = "caps:nocaps";  # keyboard is managed home-manager

      libinput = {
        enable = true;
        mouse.naturalScrolling = true;
        touchpad = {
          tapping = true;
          naturalScrolling = true;
        };
      };

      displayManager = {
        lightdm = {
          enable = true;
          greeters = {
            gtk = {
              enable = true;
              cursorTheme = {
                name = "Dracula-cursors";
                package = pkgs.dracula-theme;
                size = 32;
              };
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
        defaultSession = "none+xsession";
        sessionCommands = ''
          ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
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
