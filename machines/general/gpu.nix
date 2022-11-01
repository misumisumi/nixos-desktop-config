{ pkgs, ... }:

{
  services = {
    xserver = {
      videoDrivers = [
        "qxl"
        "amdgpu"
        "radeon"
        "nouveau"      # If you use "nvidia", You must comment this.
        "modesetting"  # If you use "nvidia", You must comment this.
        # "nvidia"
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
