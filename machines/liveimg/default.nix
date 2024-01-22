{ lib
, pkgs
, hostname
, modulesPath
, wm
, ...
}:
{
  imports =
    [
      ../../apps/documentation
      ../../apps/pkgs
      ../../apps/programs
      ../../system/console
      ../../system/environment
      ../../system/locale
      ../../system/network
      ../../system/nix
      ../../system/security
      ../init
      ./network.nix
      ./ssh.nix
      ./system.nix
      ./user.nix
      ./zfs.nix
    ] ++ lib.optional (wm == "gnome") ../../apps/gnome
    ++ lib.optionals (! lib.hasSuffix "iso" hostname) [
      ../../system/bluetooth
      ../../system/fonts
      ../../system/pulseaudio
      ./filesystem.nix
      ./gpu.nix
      ./hardware-configuration.nix
    ]
    ++ lib.optional (lib.hasSuffix "iso" hostname) ./iso.nix
  ;
}
