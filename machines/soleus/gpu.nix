{ config, lib, pkgs, ... }: {
  services = {
    xserver = {
      exportConfiguration = true;
      videoDrivers = [
        "modesetting"
        "nvidia"
      ];
    };
  };

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      powerManagement.enable = true;
      nvidiaPersistenced = true;
    };
    opengl.extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
}
