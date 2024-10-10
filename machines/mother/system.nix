{ config, ... }:
{
  boot = {
    loader.timeout = 10;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "v4l2loopback"
      "snd-aloop"
    ];
    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };
  };
  services.xserver = {
    xp-pentablet.enable = true;
    displayManager.lightdm.greeters.slick.cursorTheme.size = 32;
  };
  nix = {
    settings = {
      cores = 6;
      max-jobs = 4;
    };
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };
}
