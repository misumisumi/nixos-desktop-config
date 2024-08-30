{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      copyToClipboard
      hidePodcasts
      history
      keyboardShortcut
      songStats
      {
        src = pkgs.fetchgit {
          url = "https://github.com/L3-N0X/spicetify-dj-info";
          rev = "b55c9b8c8b00100b42e562829c77d012191f0c07";
          hash = "sha256-cR1EndjBN7jGtD0zA1f/vjkjgqslBxTiNAGDxBGEYdE=";
        };
        name = "djinfo.js";
      }
    ];
  };
}
