{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs.cinnamon; [
      (nemo-with-extensions.override {extensions = with pkgs.cinnamon; [nemo-emblems nemo-fileroller];})
    ];
  };
}
