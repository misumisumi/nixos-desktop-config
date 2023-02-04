# Image Viewer and Movie Player and Downloader
{ pkgs, ... }:

{
  programs = {
    feh.enable = true;

    mpv = {
      enable = true;
      config = {
        osd-fractions = true;
        osd-level = 2;
        no-keepaspect-window = true;
        ytdl-format = "bestvideo+bestaudio";
      };
    };

    yt-dlp = {
      enable = true;
    };
  };
}
