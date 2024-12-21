{ chezmoiToNix, ... }:
{
  editorconfig.enable = true;
  home.file = chezmoiToNix {
    chezmoiSrc = "dot_editorconfig";
  };
}
