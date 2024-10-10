{ pkgs, ... }:
{
  services = {
    xserver = {
      exportConfiguration = true;
      videoDrivers = [
        "modesetting"
        "nvidia"
      ];
      serverFlagsSection = ''
        Option "AutoAddGPU" "false"
      '';
      extraConfig = ''
        Section "Device"
          Identifier     "intel"
          Driver         "modesetting"
          BoardName      "Intel HD Graphics 630"
          BusID          "PCI:0:2:0"
        EndSection
      '';
    };
  };

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      nvidiaPersistenced = true;
      open = false;
      powerManagement.enable = true;
    };
    graphics.extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
}
