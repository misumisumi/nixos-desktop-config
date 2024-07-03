{ inputs
, pkgs
, ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.spicetify =
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

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
            rev = "50f417c554529c54ab7d4b398d505beca94ef417";
            hash = "sha256-1jT+eISut0HkBVLMOWi2IpHMG2KSBnM3TzJbeSe5hKc=";
          };
          name = "djinfo.js";
        }
      ];
    };
}
