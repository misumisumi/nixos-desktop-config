{ wm, ... }:
{
  imports = [
    ../../apps/system/documentation
    ../../apps/system/nix-ld
    ../../apps/system/pkgs
    ../../apps/system/printer
    ../../apps/system/programs
    ../../apps/system/services
    ../../apps/system/sops
    ../../apps/system/ssh
    ../../apps/system/wm/${wm}
    ../../settings/system
    ../../settings/system/bluetooth
    ../../settings/system/musnix
    ../../settings/system/pipewire
    ../init
    ./gpu.nix
    ./hardware-configuration.nix
    ./network.nix
    ./rootfs.nix
    ./sops.nix
    ./system.nix
    ./virtualisation.nix
    ./zfs.nix
  ];
}
