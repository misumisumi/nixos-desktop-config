{ pkgs, ... }:

{
  home.packages = with pkgs; [ ranger ueberzug ];
  xdg = {
    configFile = {
      "ranger".source = ./ranger;
    };
  };
}
