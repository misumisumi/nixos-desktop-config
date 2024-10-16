{
  lib,
  hostname,
  colorTheme,
  ...
}:
with builtins;
{
  imports =
    [
      ../../apps/system/documentation
      ../../apps/system/pkgs
      ../../apps/system/programs
      ../../settings/system/bluetooth
      ../../settings/system/console
      ../../settings/system/environment
      ../../settings/system/fonts
      ../../settings/system/locale
      ../../settings/system/network
      ../../settings/system/nix
      ../../settings/system/pipewire
      ../../settings/system/security
      ../init
      ./network.nix
      ./ssh.nix
      ./system.nix
      ./user.nix
      ./zfs.nix
    ]
    ++ lib.optional (colorTheme != null) ../../apps/color-theme/system/${head (split "-" colorTheme)}
    ++ lib.optional ((lib.match ".*(gnome).*" hostname) != null) ../../apps/system/gnome
    ++ lib.optionals (!lib.hasSuffix "iso" hostname) [
      ./filesystem.nix
      ./gpu.nix
      ./hardware-configuration.nix
    ]
    ++ lib.optional (lib.hasSuffix "iso" hostname) ./iso.nix;
}
