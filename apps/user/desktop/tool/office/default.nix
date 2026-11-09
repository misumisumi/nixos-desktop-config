{ pkgs, ... }:
{
  imports = [
    ./zathura
  ];
  home.packages = with pkgs; [
    ibis-office-bin
    pympress
    xournalpp
  ];
}
