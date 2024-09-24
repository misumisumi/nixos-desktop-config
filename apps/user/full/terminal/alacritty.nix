let
  font = "Moralerspace Neon NF";
in
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "xterm-256color";
        };
        font = {
          normal = {
            family = font;
            style = "Regular";
          };
          bold = {
            family = font;
            style = "Bold";
          };
          italic = {
            family = font;
            style = "Italic";
          };
          size = 10;
        };
      };
    };
  };
}
