{
  lib,
  hostname,
  wm,
  ...
}:
{
  imports =
    [
      ../../apps/system/documentation
      ../../apps/system/pkgs
      ../../apps/system/programs
      ../../settings/system/console
      ../../settings/system/environment
      ../../settings/system/locale
      ../../settings/system/network
      ../../settings/system/nix
      ../../settings/system/security
      ../init
      ./network.nix
      ./ssh.nix
      ./system.nix
      ./user.nix
      ./zfs.nix
    ]
    ++ lib.optional (wm == "gnome") ../../apps/gnome
    ++ lib.optionals (!lib.hasSuffix "iso" hostname) [
      ../../settings/system/bluetooth
      ../../settings/system/fonts
      ../../settings/system/pulseaudio
      ./filesystem.nix
      ./gpu.nix
      ./hardware-configuration.nix
    ]
    ++ lib.optional (lib.hasSuffix "iso" hostname) ./iso.nix;
}
