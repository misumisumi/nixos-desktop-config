{ pkgs, lib, ... }:
{
  home.packages =
    with pkgs;
    [
      haskellPackages.pandoc-crossref
      pandoc # Document Converter
      pandoc-plantuml-filter
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ mermaid-filter ];
}
