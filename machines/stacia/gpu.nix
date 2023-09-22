{ pkgs, ... }: {
  services = {
    xserver = {
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
    nvidia.powerManagement.enable = true;
    opengl.extraPackages = with pkgs; [
      amdvlk
      libvdpau-va-gl
      vaapiVdpau
      rocm-opencl-icd
    ];
  };
}
