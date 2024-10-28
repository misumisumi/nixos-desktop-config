{ pkgs, ... }:
{
  services = {
    xserver = {
      exportConfiguration = true;
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
      deviceSection = ''
        Option "DRI" "3"
        Option "TearFree" "true"
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
