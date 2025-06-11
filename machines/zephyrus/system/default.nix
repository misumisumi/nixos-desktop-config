{ inputs, colorTheme, ... }:
with builtins;
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    ../../../apps/color-theme/system/${head (split "-" colorTheme)}
    ../../../apps/system/documentation
    ../../../apps/system/nix-ld
    ../../../apps/system/pkgs
    ../../../apps/system/printer
    ../../../apps/system/programs
    ../../../apps/system/services
    ../../../apps/system/sops
    ../../../apps/system/ssh
    ../../../apps/system/steam
    ../../../apps/system/wm/qtile
    ../../../apps/system/yubikey
    ../../../settings/system
    ../../../settings/system/bluetooth
    ../../../settings/system/pipewire
    ../../init
    ./disks/rootfs.nix
    ./disks/system.nix
    ./gpu.nix
    ./hardware-configuration.nix
    ./network.nix
    ./persist/nix-daemon.nix
    ./persist/persistence.nix
    ./persist/snapper.nix
    ./sops.nix
    ./system.nix
    ./virtualisation.nix
  ];
}
