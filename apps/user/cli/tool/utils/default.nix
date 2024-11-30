{ pkgs, ... }:
{
  home = {
    shellAliases = {
      tty-clock = "tty-clock -c -C 6";
    };
    packages = with pkgs; [
      ascii-image-converter # Make ascii art
      cmatrix # Lain of character
      figlet # Make AA from character
      tty-clock # CLI clock
    ];
  };
}
