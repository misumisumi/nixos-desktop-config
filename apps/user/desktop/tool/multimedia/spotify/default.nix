{
  inputs,
  pkgs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
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
        src = "${inputs.spicetify-djinfo}/dist";
        name = "djinfo.mjs";
      }
    ];
  };
}
