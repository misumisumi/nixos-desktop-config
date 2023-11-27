{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    ./gpu.nix
    ./hardware-configuration.nix
    ./network.nix
    ./sops.nix
    ./system.nix
    ./virtualisation.nix
    ../init
    ../../system
    ../../system/bluetooth
    ../../system/pipewire
    ../../apps/documentation
    ../../apps/nix-ld
    ../../apps/openfortivpn
    ../../apps/pkgs
    ../../apps/printer
    ../../apps/programs
    ../../apps/services
    ../../apps/sops
    ../../apps/ssh
    ../../apps/wm/qtile
  ];
}
