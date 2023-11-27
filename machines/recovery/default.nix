{ lib, wm, ... }: {
  imports =
    [
      ./gpu.nix
      ./hardware-configuration.nix
      ./network.nix
      ./system.nix
      ../init
      ../../system
      ../../system/bluetooth
      ../../system/pulseaudio
      ../../apps/documentation
      ../../apps/pkgs
      ../../apps/programs
    ] ++ lib.optional (wm == "gnome") ../../apps/gnome;
}
