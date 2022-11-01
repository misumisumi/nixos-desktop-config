{ pkgs, ... }:

{
  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "radeon"
        "nvidia"
      ];
    };
  };

  hardware = {
    opengl.extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
      intel-ocl
      rocm-opencl-icd
    ];
  };
}
