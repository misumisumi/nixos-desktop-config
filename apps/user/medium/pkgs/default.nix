{ pkgs
, ...
}:
{
  home = {
    packages = with pkgs;[
      ascii-image-converter # Make ascii art
      cmatrix # Lain of character
      ffmpeg # Multi media solution
      figlet # Make AA from character
      graphicsmagick # CLI Image Editor
      pandoc # Document Converter
      playerctl # CLI control media
      sox # CLI Sound Editor
    ];
  };
}
