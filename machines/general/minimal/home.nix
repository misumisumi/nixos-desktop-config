{ lib
, pkgs
, ...
}: {
  programs.neovim.useMyDots.enable = true;
  programs.editorconfig.useMyDots.enable = true;
  home = {
    setupCommonPkgs = {
      enable = true;
    };
    packages =
      (import ../../../apps/userWide/pkgs {
        inherit lib pkgs;
      })
      ++ (with pkgs; [ pacman arch-install-scripts vscode ]);
  };
}
