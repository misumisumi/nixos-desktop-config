{
  programs.mpv = {
    enable = true;
    config = {
      keepaspect = true;
      osd-fractions = true;
      osd-level = 2;
      ytdl-format = "bestvideo+bestaudio";
    };
  };
}
