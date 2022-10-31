{ pkgs, ... }:
let
  browsers = [ "vivaldi-stable.desktop" "firefox.desktop" ];
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "zathura-pdf-mupdf.desktop" "vivaldi-stable.desktop" ];
      "text/html" = browsers;
      "text/xml" = [ "neovim.desktop" ] ++ browsers;
      "x-scheme-handler/ftp" = browsers;
      "x-scheme-handler/http" = browsers;
      "x-scheme-handler/https" = browsers;
    };
  };
}
