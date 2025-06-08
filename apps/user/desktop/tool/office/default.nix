{ pkgs, ... }:
{
  imports = [
    ./libreoffice
    ./zathura
  ];
  home.packages = with pkgs; [
    pympress
    xournalpp
  ];
}
