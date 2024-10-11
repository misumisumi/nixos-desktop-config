{ pkgs, ... }:
{
  programs.yt-dlp.enable = true;
  home.packages = with pkgs; [
    ffmpeg # Multi media solution
    gnuplot # CLI Plotter
    graphicsmagick # CLI Image Editor
    sox # CLI Sound Editor
  ];
}
