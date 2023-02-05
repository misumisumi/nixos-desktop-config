{ pkgs, ... }:

{
  services = {
    xserver = {
      videoDrivers = [
        "nvidia"
        "modesetting"
        "fbdev"
      ];
      deviceSection = ''
        Driver         "nvidia"
        VendorName     "NVIDIA Corporation"
        BoardName      "NVIDIA GeForce GTX 1050 Ti"
        BusID          "PCI:9:0:0"
      '';
      monitorSection = ''
        VendorName     "Unknown"
        ModelName      "IODATA EX-LDGCQ241D"
        HorizSync       15.0 - 90.0
        VertRefresh     24.0 - 76.0
        Option         "DPMS"
      '';
      screenSection = ''
        DefaultDepth    24
        Option         "Stereo" "0"
        Option         "nvidiaXineramaInfoOrder" "DFP-2"
        Option         "metamodes" "DP-0: nvidia-auto-select +1920+0, HDMI-0: nvidia-auto-select +4480+0, DVI-D-0: nvidia-auto-select +0+360"
        # Option         "metamodes" "DP-0: nvidia-auto-select +1920+0, HDMI-0: nvidia-auto-select +4480+0"
        Option         "SLI" "Off"
        Option         "MultiGPU" "Off"
        Option         "BaseMosaic" "off"
        SubSection     "Display"
            Depth       24
        EndSubSection
      '';
    };
  };

  hardware = {
    nvidia.modesetting.enable = true;
    opengl.extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
}
