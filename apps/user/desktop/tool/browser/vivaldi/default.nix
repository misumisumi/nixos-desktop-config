{ pkgs, ... }:
{
  home.sessionVariables = {
    CHROME_PATH = "${pkgs.vivaldi}/bin/vivaldi";
  };
  programs.vivaldi = {
    enable = true;
    package = pkgs.vivaldi.override { proprietaryCodecs = true; };
    dictionaries = with pkgs; [ hunspellDictsChromium.en_US ];
    extensions = [
      { id = "joaffhoebddkohkafembmdkfmmcgmepj"; } # better vrchat
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "bniigfmpkmcabajbkelbmphoelijoang"; } # clean-spam-link-tweet
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "elfdpkmfllnhhgnicaaeacbilcallpbd"; } # flow chat for youtube live
      { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # google docs offline
      { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # i don't care about cookies
      { id = "neebplgakaahbhdphmkckjjcegoiijjo"; } # keepa
      { id = "ophjlpahpchlmihnnnihgmmeilfjmjjc"; } # line
      { id = "cnjifjpddelmedmihgijeibhnjfabmlf"; } # obsidian web clipper
      { id = "mhpjgcccinlocgiklkfllehilgmcnimp"; } # paperpal for overleaf beta
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
      { id = "ldgfbffkinooeloadekpmfoklnobpien"; } # raindrop.io
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
