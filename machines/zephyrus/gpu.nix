{ pkgs, ... }:
{
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfff7ffff" ];
  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
      deviceSection = ''
        Driver "amdgpu"
        Option "DRI" "3"
        Option "EnablePageFlip" "off"
        Option "TearFree" "false"
      '';
    };
  };

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      open = false;
      powerManagement.enable = true;
    };
    graphics.extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau
      rocm-opencl-icd
    ];
  };
}
