{pkgs, ...}: {
  programs = {
    feh.enable = true;
    yt-dlp. enable = true;
    mangohud.enable = true;

    mpv = {
      enable = true;
      config = {
        osd-fractions = true;
        osd-level = 2;
        no-keepaspect-window = true;
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
