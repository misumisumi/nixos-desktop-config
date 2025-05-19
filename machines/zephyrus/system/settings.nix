{ pkgs, config, ... }:
{
  hardware.brillo.enable = true; # for brightness control from users in the video group
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
    printing.drivers = with pkgs; [
      cnijfilter2
    ];
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
