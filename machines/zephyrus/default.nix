{
  inputs,
  wm,
  colorTheme,
  ...
}:
with builtins;
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    ../../apps/system/color-theme/${head (split "-" colorTheme)}
    ../../apps/system/documentation
    ../../apps/system/nix-ld
    ../../apps/system/pkgs
    ../../apps/system/printer
    ../../apps/system/programs
    ../../apps/system/services
    ../../apps/system/sops
    ../../apps/system/ssh
    ../../apps/system/steam
    ../../apps/system/wm/${wm}
    ../../settings/system
    ../../settings/system/bluetooth
    ../../settings/system/pipewire
    ../../settings/system/systemd/openfortivpn
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
