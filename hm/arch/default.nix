{
  imports = (import ../../apps/common/cli) ++
            (import ../../apps/common/git) ++
            (import ../../apps/common/neovim) ++
            (import ../../apps/common/shell) ++
            (import ../../apps/common/ssh) ++
            (import ../../apps/desktop);

  home = {
    packages = (import ../../apps/common/pkgs) pkgs ++
               (import ../../apps/desktop/pkgs) pkgs;

  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };
}
