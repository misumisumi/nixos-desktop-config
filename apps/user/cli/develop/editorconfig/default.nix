{ chezmoiToNix, ... }:
{
  editorconfig.enable = true;
  home.file = chezmoiToNix {
    chezmoiSrc = "readonly_dot_editorconfig";
  };
}
