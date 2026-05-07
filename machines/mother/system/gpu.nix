{ pkgs, ... }:
{
  services = {
    xserver = {
      videoDrivers = [
        "modesetting"
        # "nvidia"
        "amdgpu"
        "fbdev"
      ];
      deviceSection = "";
      serverFlagsSection = ''
        Option "AutoAddGPU" "false"
      '';
      extraConfig = ''
        Section "Device"
          Identifier     "Intel Arc B580"
          Driver         "modesetting"
          VendorName     "Intel Corporation"
          BoardName      "Battlemage G21 [Arc B570]"
          BusID          "PCI:05:0:0"
          Option         "Monitor-DP-1" "DP-1"
          Option         "Monitor-HDMI-2" "HDMI-2"
          Option         "Monitor-HDMI-3" "HDMI-3"
        EndSection

        Section "Device"
          Identifier     "Radeon Graphics"
          Driver         "amdgpu"
          VendorName     "Advanced Micro Devices, Inc."
          BoardName      "[AMD/ATI] Graphics Ridge [Radeon Greaphics] (rev ca)"
          BusID          "PCI:11:0:0"
        EndSection

        Section "Monitor"
            Identifier "DP-1"
            Option "Primary" "true"
        EndSection

        Section "Monitor"
          Identifier     "HDMI-2"
          Option         "RightOf" "DP-1"
        EndSection

        Section "Monitor"
          Identifier     "HDMI-3"
          Option         "RightOf" "HDMI-2"
        EndSection
      '';
      # screenSection = ''
      #   DefaultDepth    24
      #   Option         "Stereo" "0"
      #   Option         "nvidiaXineramaInfoOrder" "DP-0,HDMI-0,DVI-D-0"
      #   Option         "metamodes" "DP-0: nvidia-auto-select +0+0, HDMI-0: nvidia-auto-select +2560+0, DVI-D-0: nvidia-auto-select +5120+0"
      #   Option         "SLI" "Off"
      #   Option         "MultiGPU" "Off"
      #   Option         "BaseMosaic" "off"
      #   SubSection     "Display"
      #       Depth       24
      #   EndSubSection
      # '';
    };
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=0"
  ];
  hardware = {
    # nvidia-container-toolkit.enable = true;
    # nvidia = {
    #   modesetting.enable = true;
    #   open = true;
    # };
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        # for Intel Arc
        vpl-gpu-rt
        intel-compute-runtime
        # for NVIDIA
        nvidia-vaapi-driver
        # for hardware video acceleration
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };
}
