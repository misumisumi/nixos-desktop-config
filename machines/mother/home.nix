{ lib
, hostname
, pkgs
, ...
}: {
  programs.ssh.useMyDots.enable = true;
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
    import ../../apps/userWide
      {
        inherit lib hostname;
        isLarge = true;
      }
    ++ (import ../../apps/userWide/wm/qtile);

  home = {
    installCommonPkgs = {
      enable = true;
      isLarge = true;
    };
    packages =
      (import ../../apps/userWide/pkgs {
        inherit lib pkgs;
        isFull = true;
      })
      ++ (with pkgs; [ evtest xp-pen-driver ]);
  };

  xresources = {
    extraConfig = "Xft.dpi:100";
  };
}
