{ config, ... }:
let
  inherit (config.lib.ndchm.chezmoi) importFilesFromChezmoi;
in
{
  editorconfig.enable = true;
  home.file = importFilesFromChezmoi {
    chezmoiSrc = "dot_editorconfig";
  };
}
