{ pkgs, lib, ... }:
{
  home = {
    shellAliases = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
      tty-clock = "tty-clock -c -C 6";
    };
    packages =
      with pkgs;
      [
        ascii-image-converter # Make ascii art
        cmatrix # Lain of character
        figlet # Make AA from character
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
        tty-clock # CLI clock
      ];
  };
}
