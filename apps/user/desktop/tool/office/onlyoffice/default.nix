{ lib, pkgs, ... }:
{
  programs.onlyoffice = {
    enable = true;
    settings = {
      UITheme = "theme-night";
      editorWindowMode = false;
      locale = "ja-JP";
      titlebar = "custom";
    };
  };
  home.activation.copyFontsForOnlyOffice =
    let
      inherit (lib) concatMapStringsSep;
      fonts = with pkgs; [
        corefonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
      ];
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf ~/.local/share/fonts
      mkdir -p ~/.local/share/fonts
      font_regexp='.*\.\(ttf\|ttc\|otf\|pcf\|pfa\|pfb\|bdf\)\(\.gz\)?'
      ${concatMapStringsSep "\n" (
        x: "find ${x} -regex $font_regexp -exec cp '{}' ~/.local/share/fonts/ \\;"
      ) fonts}
      chmod 544 ~/.local/share/fonts
      chmod 444 ~/.local/share/fonts/*
    '';
}
