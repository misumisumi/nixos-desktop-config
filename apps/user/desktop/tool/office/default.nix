{ pkgs, ... }:
{
  imports = [
    ./onlyoffice
    ./zathura
  ];
  home.packages = with pkgs; [
    pympress
    xournalpp
  ];
}
