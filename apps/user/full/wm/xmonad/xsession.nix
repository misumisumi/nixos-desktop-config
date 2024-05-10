{ pkgs, ... }: {
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = with pkgs.haskellPackages; [
      monad-logger
    ];
  };
}
