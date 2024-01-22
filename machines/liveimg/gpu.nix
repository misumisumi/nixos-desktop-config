{ pkgs, ... }: {
  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nouveau"
        "qxl"
        "modesetting"
        "fbdev"
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
