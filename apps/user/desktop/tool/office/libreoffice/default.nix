{ pkgs, ... }:
{
  home = {
    shellAliases = {
      pdfpc = "WEBKIT_DISABLE_DMABUF_RENDERER=1 pdfpc"; # Workaround for speaker notes not displaying properly
    };
    packages = with pkgs; [
      libreoffice # Office Suite
    ];
  };
}
