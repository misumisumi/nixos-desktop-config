{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./network.nix
    ../../apps/common/virtualisation
    ../../apps/desktop/wm/configuration.nix
  ];
  
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };

  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
    };
  };

  hardware.opengl.extraPackages = [
    rocm-opencl-icd
  ];
}
