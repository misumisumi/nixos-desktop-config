{ pkgs, ... }:
{
  home.packages = with pkgs; [
    evince # PDF viewer
    liberation_ttf # Font for Latex (replacement for arial, times, courier)
    lmodern # Font for LaTex (default of lualatex)
    poppler-utils # A PDF rendering
  ];
  xdg.configFile."latexmk/latexmkrc" = {
    enable = true;
    source = ./latexmkrc;
  };
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: {
      inherit (tpkgs)
        algorithms
        boondox
        collection-fontsrecommended
        collection-langjapanese
        collection-latexextra
        fontaxes
        ipaex
        latexmk
        newpx
        newtx
        newtxtt
        scheme-medium
        tipa
        tlmgrbasics
        ;
    };
  };
}
