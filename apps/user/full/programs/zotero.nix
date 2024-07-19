{ pkgs, user, ... }:
{
  programs.zotero = {
    enable = true;
    profiles."${user}" = {
      settings = {
        "extensions.zotero.ZoteroPDFTranslate.dictSource" = "webliodict";
        "extensions.zotero.ZoteroPDFTranslate.targetLanguage" = "ja";
        "extensions.zotero.ZoteroPDFTranslate.translateSource" = "googleapi";
      };
      extensions = with pkgs.zotero-addons; [
        zotero-better-bibtex
        zotero-night
        zotero-pdf-translate
        zotero-zotfile
      ];
    };
  };
}
