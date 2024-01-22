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
    nvidia = {
      powerManagement.enable = true;
      nvidiaPersistenced = true;
    };
    opengl.extraPackages = with pkgs; [
      amdvlk
      libvdpau-va-gl
      vaapiVdpau
      rocm-opencl-icd
    ];
  };
}
