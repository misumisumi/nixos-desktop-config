{ lib
, hostname
, modulesPath
, wm
, ...
}:
{
  imports =
    [
      ./filesystem.nix
      ./gpu.nix
      ./network.nix
      ./ssh.nix
      ./system.nix
      ./zfs.nix
      ../init
      ../../system
      ../../system/bluetooth
      ../../system/pulseaudio
      ../../apps/documentation
      ../../apps/pkgs
      ../../apps/programs
    ] ++ lib.optional (wm == "gnome") ../../apps/gnome
    ++ lib.optional (! lib.hasSuffix "iso" hostname) ./hardware-configuration.nix
    ++ lib.optional (lib.hasSuffix "iso" hostname) ./iso.nix
  ;
}
