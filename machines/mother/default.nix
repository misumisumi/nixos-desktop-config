{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../apps/desktop/wm
  ];
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];

      defaultDepth = 24;

      serverLayoutSection = ''
        Option         "Xinerama" "0"
      '';

      deviceSection = ''
        Identifier     "Device0"
        Driver         "nvidia"
        VendorName     "NVIDIA Corporation"
        BoardName      "NVIDIA GeForce GTX 1050 Ti"
        BusID          "PCI:9:0:0"
      '';

      screenSection = ''
        Option         "nvidiaXineramaInfoOrder" "DFP-2"
        Option         "metamodes" "DP-0: nvidia-auto-select +1920+0, HDMI-0: nvidia-auto-select +4480+0, DVI-D-0: nvidia-auto-select +0+360"
        Option         "SLI" "Off"
        Option         "MultiGPU" "Off"
        Option         "BaseMosaic" "off"
      '';

    };
  };
}
