{
  inputs,
  system,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
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
        src = fetchFromGitHub {
          owner = "L3-N0X";
          repo = "spicetify-dj-info";
          rev = "9f5ef20697aa5613490c21278889fb007c594610";
          sha256 = "sha256-FbDgfbrvM+Sz7/CgRdtB6oOMndlnb2SPsNFosuV7+AY=";
        };
        name = "dist/djinfo.mjs";
      }

    ];
  };
}
