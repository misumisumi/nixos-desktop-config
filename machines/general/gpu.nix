{ pkgs, ... }:

{
  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nvidia"
        "modesetting"
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
