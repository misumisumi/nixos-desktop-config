{ config, lib, pkgs, ... }: {
  services = {
    xserver = {
      exportConfiguration = true;
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
      deviceSection = ''
        Option "DRI" "3"
        Option "TearFree" "true"
      '';
    };
  };

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      powerManagement.enable = true;
      nvidiaPersistenced = true;
    };
    graphics.extraPackages = with pkgs; [
      amdvlk
      libvdpau-va-gl
      vaapiVdpau
      rocm-opencl-icd
    ];
  };
}
