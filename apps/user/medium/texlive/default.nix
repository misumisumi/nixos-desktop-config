{ pkgs, ... }:
{
  home.packages = with pkgs; [
    liberation_ttf # Font for Latex
    lmodern # Font for LaTex
    poppler_utils # A PDF rendering
  ];
  xdg.configFile."latexmkrc" = {
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
        tlmgrbasics
        ;
    };
  };
}
