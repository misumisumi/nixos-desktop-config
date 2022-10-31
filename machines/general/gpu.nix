{ pkgs, ... }:

{
  services = {
    xserver = {
      videoDrivers = [
        "modesetting"
        "amdgpu"
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
