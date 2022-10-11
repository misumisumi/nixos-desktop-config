{ config, lib, pkgs, ... }:

{
  security.pam.services.login.enableGnomeKeyring = true; 
  services = {
    xserver = {
      enable = true;
      autorun = true;

      layout = "us";
      xkbOptions = "caps:control_l, super_l:alt_l, alt_l:super_l";

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
            pantheon = {
              enable = true;
            };
          };
        };
        # defaultSession = "none+i3";
        sessionCommands = ''
          ${pkgs.xorg.xrandr}/bin/xrandr --auto
        '';
      };
      windowManager.qtile.enable = true;
      desktopManager.pantheon.enable = true;
      # windowManager.i3 = {
      #   enable = true;
      #   package = pkgs.i3-gaps;
      # };

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
