{ user, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles."${user}" = {
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
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
  };
}
