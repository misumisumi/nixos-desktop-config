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
          Driver         "amdgpu"
          BusID          "PCI:30:0:0"
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
