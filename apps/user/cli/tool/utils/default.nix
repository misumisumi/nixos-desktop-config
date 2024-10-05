{ pkgs, ... }:
{
  home = {
    shellAliases = {
      tty-clock = "tty-clock -c -C 6";
    };
    packages = with pkgs; [
      ascii-image-converter # Make ascii art
      cava # Console-based Audio Visualizer for Alsa
      cmatrix # Lain of character
      figlet # Make AA from character
      tty-clock # CLI clock
    ];
  };
}
