{ pkgs, config, ... }:
{
  home = {
    packages = [
      (pkgs.writeShellApplication {
        name = "export-vivaldi-config";
        text = ''
          PROFILE=''${1:-Default}
          ITEMS=(
            ".vivaldi.actions"
            ".vivaldi.address_bar.inline_search"
            ".vivaldi.address_bar.omnibox"
            ".vivaldi.address_bar.search"
            ".vivaldi.appearance"
            ".vivaldi.chained_commands"
            ".vivaldi.dashboard"
            ".vivaldi.features"
            ".vivaldi.mail"
            ".vivaldi.mouse_wheel"
            ".vivaldi.panels"
            ".vivaldi.quick_commands"
            ".vivaldi.tabs.bar"
            ".vivaldi.toolbars"
          )
          # ITEMSを", "で連結、ただし、末尾に,を付けない
          joined_string=''$(printf ", %s" "''${ITEMS[@]}")
          joined_string=''${joined_string:2} # Remove the leading comma and space

          jq -c "pick(''${joined_string})" "''${XDG_CONFIG_HOME}/vivaldi/''${PROFILE}/Preferences"
        '';
      })
    ];
    sessionVariables = {
      CHROME_PATH = "${pkgs.vivaldi}/bin/vivaldi";
    };
  };
  xdg.configFile."vivaldi/CommonPreferences" = {
    source = ../../../../../../chezmoi/dot_config/vivaldi/CommonPreferences;
    onChange = ''
      find "${config.xdg.configHome}/vivaldi" -maxdepth 1 -type d -name "Default" -or -name "Profile *" | while read -r profile; do
        TMP="''${profile}/Preferences.bak"
        mv "''${profile}/Preferences" "''${TMP}"
        ${pkgs.jq}/bin/jq -r -s '.[0] * .[1]' "''${TMP}" ${config.xdg.configHome}/vivaldi/CommonPreferences > "''${profile}/Preferences.new"
        if [ -s "''${profile}/Preferences.new" ]; then
          mv "''${profile}/Preferences.new" "''${profile}/Preferences"
        else
          rm "''${profile}/Preferences.new"
        fi
      done
    '';
  };
  programs.vivaldi = {
    enable = true;
    dictionaries = with pkgs; [ hunspellDictsChromium.en_US ];
    extensions = [
      { id = "joaffhoebddkohkafembmdkfmmcgmepj"; } # better vrchat
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "bniigfmpkmcabajbkelbmphoelijoang"; } # clean-spam-link-tweet
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "elfdpkmfllnhhgnicaaeacbilcallpbd"; } # flow chat for youtube live
      { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # google docs offline
      { id = "dahenjhkoodjbpjheillcadbppiidmhp"; } # google scholar pdf reader
      { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # i don't care about cookies
      { id = "neebplgakaahbhdphmkckjjcegoiijjo"; } # keepa
      { id = "ophjlpahpchlmihnnnihgmmeilfjmjjc"; } # line
      { id = "cnjifjpddelmedmihgijeibhnjfabmlf"; } # obsidian web clipper
      { id = "mhpjgcccinlocgiklkfllehilgmcnimp"; } # paperpal for overleaf beta
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
      { id = "ejcfdikabeebbgbopoagpabbdokepnff"; } # rajiko
      { id = "pncfbmialoiaghdehhbnbhkkgmjanfhe"; } # ublock list
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; } # video speed controller
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "oingodpdjohhkelnginmkagmkbplgema"; } # weblioポップアップ英和辞典
      { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } # zotero connector
      {
        id = "bolggfoncklhniejomgplkjcllmnonbh";
        updateUrl = "https://raw.githubusercontent.com/FilipePS/Traduzir-paginas-web/master/updates.xml";
      } # translate web pages
      {
        id = "ajdlpmoffekghhblfajmiacgbdknmbpa";
        updateUrl = "https://raw.githubusercontent.com/misumisumi/Chromium-Extensions-auto-packer/main/BetterTweetDeckOTD/updates.xml";
      } # Better TweetDeck (OldTweetDeck-compatible)
      {
        id = "bjcdldglejahkljjcjhpdclapfpiphhf";
        updateUrl = "https://raw.githubusercontent.com/misumisumi/Chromium-Extensions-auto-packer/main/OldTweetDeck/updates.xml";
      } # OldTweetDeck
    ];
  };
}
