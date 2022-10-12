{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./network.nix
    ../../apps/desktop/wm/configuration.nix
  ] ++
  (import ../../apps/common/virtualisation);
  
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 24
    '';
  };

  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
      ];
    };
  };

  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
  ];
}
