{ lib
, pkgs
, ...
}:
let
  nemo-with-extensions = pkgs.cinnamon.nemo-with-extensions.override { extensions = with pkgs.cinnamon; [ nemo-emblems nemo-fileroller ]; };
in
{
  home = {
    packages = [ nemo-with-extensions ];
  };
  xdg.mimeApps.defaultApplications."inode/directory" = "nemo.desktop";
}
