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
      rocm-opencl-icd
    ];
  };
}
