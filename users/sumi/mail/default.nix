{ pkgs, ... }:
{
  accounts.email.accounts = {
    "sumi-sumi" = {
      primary = true;
      realName = "Sumi-Sumi";
      address = "dragon511southern@gmail.com";
      userName = "dragon511southern@gmail.com";
      flavor = "gmail.com";
      signature = {
        showSignature = "append";
        delimiter = "";
        text = ''
          --------------------------------------------<br>
          Sumi-Sumi<br>
          <br>
          Mail: sumi2@misumi-sumi.com<br>
          X: @SumiSumiVRC<br>
          --------------------------------------------
        '';
      };
      aliases = [
        "sumi2@misumi-sumi.com"
      ];
      thunderbird = {
        enable = true;
        profiles = [ "private" ];
        settings = id: {
          "mail.identity.id_${id}.htmlSigFormat" = true;
        };
      };
    };
    "s.kobayashi" = {
      realName = "小林清流";
      address = "s.kobayashi@misumi-sumi.com";
      userName = "s.kobayashi@misumi-sumi.com";
      flavor = "gmail.com";
      signature = {
        showSignature = "append";
        delimiter = "";
        text = ''
          --------------------------------------------<br>
          東北大学大学院　工学研究科　通信工学専攻<br>
          伊藤・能勢研究室　博士課程<br>
          <br>
          小林 清流 (Kobayashi Sumiharu)<br>
          <br>
          TEL: 090-7720-7626<br>
          Mail: s.kobayashi@misumi-sumi.com<br>
          URL: https://misumisumi.github.io<br>
          --------------------------------------------
        '';
      };
      thunderbird = {
        enable = true;
        profiles = [ "work" ];
        settings = id: {
          "mail.identity.id_${id}.htmlSigFormat" = true;
        };
      };
    };
    "tohoku-u" = {
      realName = "小林清流";
      address = "kobayashi.sumiharu.r4@dc.tohoku.ac.jp";
      userName = "kobayashi.sumiharu.r4@dc.tohoku.ac.jp";
      flavor = "gmail.com";
      signature = {
        showSignature = "append";
        delimiter = "";
        text = ''
          --------------------------------------------<br>
          東北大学大学院　工学研究科　通信工学専攻<br>
          伊藤・能勢研究室　博士課程<br>
          <br>
          小林 清流 (Kobayashi Sumiharu)<br>
          <br>
          Mail: kobayashi.sumiharu.r4@dc.tohoku.ac.jp<br>
          TEL: 090-7720-7626<br>
          --------------------------------------------
        '';
      };
      thunderbird = {
        enable = true;
        profiles = [ "work" ];
        settings = id: {
          "mail.identity.id_${id}.htmlSigFormat" = true;
        };
      };
    };
  };
  programs.thunderbird = {
    enable = true;
    settings = {
      "extensions.autoDisableScopes" = 0;
      "font.language.group" = "ja";
      "intl.accept_languages" = "ja,en-US,en";
      "intl.locale.requested" = "ja";
      "mail.identity.default.suppress_signature_separator" = true;
    };
    profiles = {
      private = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          languagetool
          translate-web-pages
          pkgs.nur.repos.sigprof.thunderbird-langpack-ja
        ];
      };
      work = {
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          languagetool
          translate-web-pages
          pkgs.nur.repos.sigprof.thunderbird-langpack-ja
        ];
      };
    };
  };
}
