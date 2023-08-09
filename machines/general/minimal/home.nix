{ lib
, pkgs
, ...
}: {
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
  home = {
    installCommonPkgs = {
      enable = true;
    };
    packages =
      (import ../../../apps/userWide/pkgs {
        inherit lib pkgs;
      })
      ++ (with pkgs; [ pacman arch-install-scripts vscode ]);
  };
}

