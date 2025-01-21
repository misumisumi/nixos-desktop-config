{
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto";
      keepaspect = true;
      osd-fractions = true;
      osd-level = 2;
      ytdl-format = "bestvideo+bestaudio";
    };
  };
}
