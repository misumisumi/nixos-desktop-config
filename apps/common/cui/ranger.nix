{ pkgs, ... }:

{
  home.packages = with pkgs; [ ranger ueberzug ];
  xdg = {
    configFile = {
      "ranger/rc.conf".source = ./ranger/rc.conf;
      "ranger/rifle.conf".source = ./ranger/rifle.conf;
      "ranger/scope.sh".source = ./ranger/scope.sh;
    };
  };
}
