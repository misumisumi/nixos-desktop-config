{ config, ... }:
{
  boot = {
    supportedFilesystems = [ "ntfs" ];
    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
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
  hardware.brillo.enable = true;
  programs.nix-ld.enable = true;
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
  };
  systemd.sleep.extraConfig = ''
    # suspend=hybrid-sleep
    SuspendMode=suspend
    SuspendState=disk
    # hibernate=hybrid-sleep
    HibernateMode=suspend
    HibernateState=disk
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
