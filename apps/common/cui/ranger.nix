{ pkgs, ... }:

{
  home.packages = with pkgs; [ ranger ];
  xdg = {
    configFile = {
      "ranger".source = ./ranger;
    };
  };
}
