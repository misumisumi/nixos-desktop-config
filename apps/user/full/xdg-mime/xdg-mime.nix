{ pkgs, ... }:
let
  browsers = [ "vivaldi-stable.desktop" "firefox.desktop" ];
  image_viewer = [ "org.nomacs.ImageLounge.desktop" "feh.desktop" ];
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" "vivaldi-stable.desktop" ];
      "application/wps-office.pptx" = "impress.desktop";
      "text/html" = browsers;
      "text/xml" = [ "neovim.desktop" ] ++ browsers;
      "x-scheme-handler/ftp" = browsers;
      "x-scheme-handler/http" = browsers;
      "x-scheme-handler/https" = browsers;
      "image/gif" = image_viewer;
      "image/jpeg" = image_viewer;
      "image/png" = image_viewer;
      "image/bmp" = image_viewer;
      "image/tiff" = image_viewer;
      "image/x-eps" = image_viewer;
      "image/x-ico" = image_viewer;
      "image/x-portable-bitmap" = image_viewer;
      "image/x-portable-graymap" = image_viewer;
      "image/x-portable-pixmap" = image_viewer;
      "image/x-xbitmap" = image_viewer;
      "image/x-xpixmap" = image_viewer;
    };
  };
}
