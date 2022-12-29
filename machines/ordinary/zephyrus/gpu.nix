{ pkgs, ... }:

{
  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
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
