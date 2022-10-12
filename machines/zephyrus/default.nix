{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./network.nix
    ../../apps/desktop/wm/configuration.nix
    ../../apps/common/virtualisation/podman.nix
    ../../apps/common/virtualisation/libvirt.nix
  ];
  
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 8
    '';
  };
  services = {
    xserver = {
      videoDrivers = [
        "virtio-pci"
        "qxl"
        "amdgpu"
        "nouveau"
        "modesetting"
      ];
    };
  };
}
