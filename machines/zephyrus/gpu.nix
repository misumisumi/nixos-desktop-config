{ pkgs, ... }:

{
  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
    };
  };

  hardware = {
    opengl.extraPackages = with pkgs; [
      vaapiVdpau
      rocm-opencl-icd
      rocm-oepncl-runtime
    ];
  };
}
