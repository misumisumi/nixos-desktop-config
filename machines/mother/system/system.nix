{ pkgs, config, ... }:
{
  hardware.keyboard.qmk = {
    enable = true;
    keychronSupport = true;
  };
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelParams = [
      "amd_pstate=active"
    ];
    kernelModules = [
      "snd-aloop"
      "v4l2loopback"
    ];
  };
  programs = {
    poweroff'.enable = true;
    xppen = {
      enable = true;
      package = pkgs.xppen_3;
    };
  };
  services = {
    printing.drivers = with pkgs; [
      cnijfilter2
    ];
    xserver = {
      displayManager.lightdm.greeters.slick.cursorTheme.size = 32;
    };
  };
  nix = {
    settings = {
      cores = 4;
      max-jobs = 6;
    };
    extraOptions = ''
      http-connections = 256
    '';
  };
}
