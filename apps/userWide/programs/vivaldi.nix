{ pkgs, ... }:
{
  programs.vivaldi = {
    enable = true;
    package = (pkgs.vivaldi.override { proprietaryCodecs = true; });
    dictionaries = with pkgs; [
      hunspellDictsChromium.en_US
    ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "pncfbmialoiaghdehhbnbhkkgmjanfhe"; } # ublock list
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "chphlpgkkbolifaimnlloiipkdnihall"; } # one tab
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "neebplgakaahbhdphmkckjjcegoiijjo"; } # keepa
      { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # google docs offline
      { id = "ophjlpahpchlmihnnnihgmmeilfjmjjc"; } # line
      { id = "ejcfdikabeebbgbopoagpabbdokepnff"; } # rajiko
      { id = "mheleidccioamimekojienbdfclcbaan"; } # q accelerator
      { id = "niloccemoadcdkdjlinkgdfekeahmflj"; } # save to pocket
      { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } # zotero connector
      { id = "joaffhoebddkohkafembmdkfmmcgmepj"; } # better vrchat dot com
      { id = "diapeboihmphompedonjjbmkbhflmcek"; } # vrc url pasteExtension
      { id = "elfdpkmfllnhhgnicaaeacbilcallpbd"; } # flow chat for youtube live
      {
        id = "bolggfoncklhniejomgplkjcllmnonbh";
        updateUrl = "https://raw.githubusercontent.com/FilipePS/Traduzir-paginas-web/master/updates.xml";
      } # translate web pages
      {
        id = "mbkealjjbgdefaeolfjpmohgkbejfnli";
        updateUrl = "https://raw.githubusercontent.com/misumisumi/Chromium-Extensions-auto-packer/main/BetterTweetDeckOTD/updates.xml";
      } # Better TweetDeck (OldTweetDeck-compatible)
      {
        id = "ilpagdghakcfnlaanggbgjbmdflagajb";
        updateUrl = "https://raw.githubusercontent.com/misumisumi/Chromium-Extensions-auto-packer/main/OldTweetDeck/updates.xml";
      } # OldTweetDeck
    ];
  };
}