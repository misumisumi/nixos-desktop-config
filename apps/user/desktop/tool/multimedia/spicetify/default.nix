{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      copyToClipboard
      hidePodcasts
      history
      keyboardShortcut
      songStats
      {
        src = pkgs.fetchgit {
          url = "https://github.com/L3-N0X/spicetify-dj-info";
          rev = "c786a923eee564cff3fa5c5e0317b34cab7c80f3";
          hash = "sha256-YRkLXJivnOuy4dLZ5qutyTf0NK05Zeiy676HU2FWC0A=";
        };
        name = "djinfo.js";
      }
    ];
  };
}
