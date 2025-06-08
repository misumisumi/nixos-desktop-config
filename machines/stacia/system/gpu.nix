{ pkgs, ... }:
{
  services = {
    xserver = {
      exportConfiguration = true;
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
      serverFlagsSection = ''
        Option "AutoAddGPU" "false"
      '';
      deviceSection = ''
        Option "DRI" "3"
        Option "TearFree" "true"
      '';
      extraConfig = ''
        Section "Device"
          Identifier     "amdgpu"
          BusID          "PCI:30:0:0"
          Driver         "amdgpu"
        EndSection

        Section "Monitor"
          Identifier     "DVI-D-0"
          Option         "Primary" "true"
          Option         "PreferredMode" "1920x1200"
        EndSection

        Section "Monitor"
          Identifier     "HDMI-A-0"
          Option         "PreferredMode" "1920x1080"
          Option         "LeftOf" "DVI-D-0"
          Option         "Rotate" "left"
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
      amdvlk
      libvdpau-va-gl
      vaapiVdpau
      rocmPackages.clr.icd
    ];
  };
}
