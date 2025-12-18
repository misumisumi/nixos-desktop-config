{ pkgs, ... }:
{
  services = {
    xserver = {
      videoDrivers = [
        "nvidia"
        # "amdgpu"
        "fbdev"
      ];
      deviceSection = ''
        Driver         "nvidia"
        VendorName     "NVIDIA Corporation"
        BoardName      "NVIDIA GeForce GTX 1050 Ti"
        BusID          "PCI:03:0:0"
      '';
      # deviceSection = ''
      #   Driver         "amdgpu"
      #   VendorName     "AMD"
      #   BoardName      "Radeon Graphics"
      #   BusID          "PCI:0e:0:0"
      # '';
      screenSection = ''
        DefaultDepth    24
        Option         "Stereo" "0"
        Option         "nvidiaXineramaInfoOrder" "DP-0,HDMI-0,DVI-D-0"
        Option         "metamodes" "DP-0: nvidia-auto-select +0+0, HDMI-0: nvidia-auto-select +2560+0, DVI-D-0: nvidia-auto-select +5120+0"
        Option         "SLI" "Off"
        Option         "MultiGPU" "Off"
        Option         "BaseMosaic" "off"
        SubSection     "Display"
            Depth       24
        EndSubSection
      '';
    };
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=0"
  ];
  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      modesetting.enable = false;
      open = false;
    };
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
  };
}
