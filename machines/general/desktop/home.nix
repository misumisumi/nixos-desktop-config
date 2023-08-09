{ lib
, hostname
, pkgs
, wm
, ...
}:
with lib; {
  programs.neovim.nvimdots = {
    enable = true;
    setBuildEnv = true;
    withBuildTools = true;
    withDotNET = true;
    withGo = true;
    withHaskell = true;
    withJava = true;
    withRust = true;
    extraDependentPackages = with pkgs; [ icu ];
  };
  programs.neovim.extraPackages = with pkgs; [
    deno
  ];
  imports =
    import ../../../apps/userWide
      {
        inherit lib hostname;
        isMidium = true;
      }
    ++ (import ../../../apps/userWide/wm/${wm});

  home = {
    installCommonPkgs = {
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
