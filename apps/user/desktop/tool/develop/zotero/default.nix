{
  lib,
  pkgs,
  user,
  config,
  ...
}:
let
  inherit (lib) hm optionalString optionalAttrs;
in
{
  #NOTE: Rename filename template is managed by sqlite3, so need manually update the template in Zotero GUI if you change the template here.
  # {{ authors max="1" initialize="given" replace="\s" "_" }}
  # _{{ year }}
  # _{{ if journalAbbreviation }}
  # {{ journalAbbreviation replace=" " "_" }}_{{ publicationTitle case="snake" }}
  # {{ else }}
  # {{ publicationTitle case="snake" }}
  # {{ endif }}
  # _Vol{{ volume }}
  # {{#issue}}_No{{ issue }}{{/issue}}
  # {{#pages}}_pp{{ pages }}{{/pages}}
  programs.zotero = {
    enable = true;
    profiles."${user}" = {
      settings = {
        "extensions.zotero.baseAttachmentPath" = "${config.xdg.userDirs.publicShare}/zotero";
        "extensions.zotero.automaticTags" = false; # disable automatic tags
        "extensions.zotero.autoRenameFiles.linked" = true;
        "extensions.zotero.ZoteroPDFTranslate.dictSource" = "webliodict";
        "extensions.zotero.ZoteroPDFTranslate.targetLanguage" = "ja";
        "extensions.zotero.ZoteroPDFTranslate.translateSource" = "googleapi";
        "extensions.zotero.translators.better-bibtex.skipFields" =
          "abstract,file,doi,issn,keywords,urldate,langid,month,shorttitle";
        "extensions.zotmoov.dst_dir" = "/home/sumi/Public/zotero";
        "extensions.zotmoov.enable_subdir_move" = true;
        "extensions.zotmoov.subdirectory_string" = "{%w}";
      };
      extensions = with pkgs.zotero-addons; [
        zotero-better-bibtex
        zotero-pdf-translate
        zotero-scipdf
        zotero-zotmoov
      ];
    };
  };
  home.activation.reSignZotero = hm.dag.entryAfter [ "writeBoundary" ] (
    optionalString pkgs.stdenv.hostPlatform.isDarwin ''
      /usr/bin/codesign --force --deep --sign - ${config.home.homeDirectory}/Applications/Home\ Manager\ Apps/Zotero.app
    ''
  );
}
