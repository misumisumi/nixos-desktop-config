{ pkgs, ... }:
{
  home.packages = [ pkgs.aichat ];
  xdg.configFile."aichat/roles" = {
    source = ./roles;
    recursive = true;
  };
}
