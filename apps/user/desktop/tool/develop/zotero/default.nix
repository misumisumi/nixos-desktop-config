{ pkgs, user, ... }:
{
  programs.zotero = {
    enable = true;
    profiles."${user}" = {
      settings = {
        "extensions.zotero.automaticTags" = false; # disable automatic tags
        "extensions.zotero.ZoteroPDFTranslate.dictSource" = "webliodict";
        "extensions.zotero.ZoteroPDFTranslate.targetLanguage" = "ja";
        "extensions.zotero.ZoteroPDFTranslate.translateSource" = "googleapi";
        "extensions.zotero.translators.better-bibtex.skipFields" =
          "abstract,file,doi,issn,keywords,publisher,urldate,langid,month,shorttitle";
      };
      extensions = with pkgs.zotero-addons; [
        zotero-better-bibtex
        zotero-pdf-translate
        zotero-scipdf
        zotero-zotmoov
      ];
    };
  };
}
