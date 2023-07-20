{pkgs, ...}: {
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xfff7ffff"
  ];
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
    nvidia.powerManagement.enable = true;
    opengl.extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau
      rocm-opencl-icd
    ];
  };
}
