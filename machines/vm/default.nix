{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./network.nix
    ../../apps/desktop/wm/configuration.nix
  ];
  
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 8
    '';
  };
  services = {
    xserver = {
      videoDrivers = [
        "virtio"
        "qxl"
        "amdgpu"
        "nouveau"
        "modesetting"
      ];
    };
  };
}
