{
  lib,
  pkgs,
  config,
  ...
}:
{
  hardware = {
    brillo.enable = true; # for brightness control from users in the video group
    keyboard.qmk = {
      enable = true;
      keychronSupport = true;
    };
  };
  boot = {
    initrd.systemd.enable = true;
    kernel.sysctl = {
      "vm.swappiness" = 10; # swap is only used when RAM is full
    };
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelParams = [
      "amd_pstate=active"
    ];
    kernelModules = [
      "v4l2loopback"
      "snd-aloop"
    ];
  };
  programs.poweroff'.enable = true;
  services = {
    upower.enable = true;
    asusd = {
      enableUserService = true;
      profileConfig.text = "quiet";
    };
    supergfxd = {
      enable = true;
      settings = {
        mode = "Integrated";
        vfio_enable = true;
        vfio_save = false;
        always_reboot = false;
        no_logind = false;
        logout_timeout_s = 180;
        hotplug_type = "None";
      };
    };
    printing = {
      drivers = with pkgs; [
        cnijfilter2
        canon-cups-ufr2
      ];
    };
    xserver = {
      displayManager.lightdm.greeters.slick.cursorTheme.size = 32;
    };
    power-profiles-daemon.enable = true;
    logind = {
      settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandlePowerKey = "hibernate";
        HandlePowerKeyLongPress = "poweroff";
      };
    };
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
  '';
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
    powertop.enable = true;
  };
  nix = {
    settings = {
      cores = 4;
      max-jobs = 4;
    };
    extraOptions = ''
      http-connections = 25
    '';
  };
}
