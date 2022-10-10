{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

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
        pantheon = true;
        # lightdm = {
        #   enable = true;
        #   greeters = {
        #     pantheon = {
        #       enable = true;
        #     };
        #   };
        # };
        defaultSession = "none+qtile";
      };
      windowManager.qtile.enable = true;

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
    xorg.xev
    xorg.xkill
    xorg.xrandr
    xterm
  ];
}
