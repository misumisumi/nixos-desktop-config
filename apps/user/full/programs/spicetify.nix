{ lib
, inputs
, pkgs
, ...
}:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  programs.spicetify =
    {
      enable = true;
      theme = spicePkgs.themes.Nightlight;

      enabledExtensions = with spicePkgs.extensions; [
        copyToClipboard
        fullAppDisplay
        hidePodcasts
        history
        keyboardShortcut
        songStats
        {
          src = pkgs.fetchgit {
            url = "https://github.com/L3-N0X/spicetify-dj-info";
            rev = "6260a768743bb5d1a398c11c380517b6aaf8e8ff";
            hash = "sha256-Tb0ckjTSnsUTGp3d/U0idxwofBlkcFW2QWfAWdrv7CI=";
          };
          filename = "djinfo.js";
        }
      ];
    };
}
