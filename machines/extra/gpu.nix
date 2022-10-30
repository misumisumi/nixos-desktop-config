{ pkgs, ... }:

{
  services = {
    xserver = {
      videoDrivers = [
        "modesetting"
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
