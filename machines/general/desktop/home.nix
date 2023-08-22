{ lib
, hostname
, pkgs
, wm
, ...
}:
with lib; {
  programs.neovim.useMyDots.enable = true;
  programs.editorconfig.useMyDots.enable = true;
  imports =
    import ../../../apps/userWide
      {
        inherit lib hostname;
        isMidium = true;
      }
    ++ (import ../../../apps/userWide/wm/${wm});

  home = {
    setupCommonPkgs = {
      enable = true;
    };
    packages =
      (import ../../../apps/userWide/pkgs {
        inherit lib pkgs;
        isMidium = true;
      })
      ++ (with pkgs; [ pacman arch-install-scripts vscode ]);
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };
}
