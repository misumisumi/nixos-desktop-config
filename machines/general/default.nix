{ wm, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./gpu.nix
    ../common/pulseaudio.nix
    ../common/printer.nix
    ../../apps/desktop/wm/${wm}/xserver.nix
    ../../apps/virtualisation/podman.nix
  ];
  nix = {
    extraOptions = ''
      binary-caches-parallel-connections = 4
    '';
  };
}
