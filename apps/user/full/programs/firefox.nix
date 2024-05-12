{ user, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles."${user}".extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      darkreader
      onetab
      privacy-badger
      translate-web-pages
      ublacklist
      ublock-origin
      videospeed
      vimium
    ];
  };
}
