{ lib
, pkgs
, ...
}:
let
  nemo-with-extensions = pkgs.nemo-with-extensions.override { extensions = [ pkgs.nemo-emblems pkgs.nemo-fileroller ]; };
in
{
  home = {
    packages = [ nemo-with-extensions ];
  };
  xdg.mimeApps.defaultApplications."inode/directory" = "nemo.desktop";
}
