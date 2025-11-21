{ pkgs, ... }:
{
  imports = [
    ../../cli/common
    ../../core
  ];
  home.packages = with pkgs; [
    vim
  ];
}
