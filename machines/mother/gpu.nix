{ pkgs
, config
, ...
}: {
  # boot.extraModprobeConfig = lib.mkAfter ''
  #   softdep snd_hda_intel pre: vfio-pci
  #   softdep nouveau pre: vfio-pci
  #   softdep nvidia pre: vfio-pci
  #   softdep xhci_hcd pre: vfio-pci
  # '';
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
        BusID          "PCI:10:0:0"
      '';
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

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      modesetting.enable = true;
    };
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
      ];
    };
  };
}
