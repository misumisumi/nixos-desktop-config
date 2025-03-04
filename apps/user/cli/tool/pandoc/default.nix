{ pkgs, ... }:
{
  home.packages = with pkgs; [
    haskellPackages.pandoc-crossref
    mermaid-filter
    pandoc # Document Converter
    pandoc-plantuml-filter
  ];
}
