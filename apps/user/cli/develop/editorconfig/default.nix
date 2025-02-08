{ importFilesFromChezmoi, ... }:
{
  editorconfig.enable = true;
  home.file = importFilesFromChezmoi {
    chezmoiSrc = "dot_editorconfig";
  };
}
