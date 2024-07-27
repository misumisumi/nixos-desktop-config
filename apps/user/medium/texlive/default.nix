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
        biber
        biblatex
        biblatex-ieee
        boondox
        collection-fontsrecommended
        collection-langjapanese
        collection-latexextra
        csvsimple
        fontaxes
        ieeetran
        ipaex
        latexmk
        luatexja
        newpx
        newtx
        newtxtt
        plautopatch
        scheme-medium
        tabularray
        tlmgrbasics
        ;
    };
  };
}
