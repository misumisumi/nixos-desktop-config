{ lib
, hostname
, pkgs
, ...
}: {
  programs.ssh.useMyDots.enable = true;
  imports =
    import ../../apps/userWide
      {
        inherit lib hostname;
        isLarge = true;
      }
    ++ (import ../../apps/userWide/wm/qtile);

  home = {
    packages =
      (import ../../apps/userWide/pkgs {
        inherit lib pkgs;
        isFull = true;
      });
  };
}