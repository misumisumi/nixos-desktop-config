{ pkgs, ... }:

{
  home.packages = with pkgs; [ devbox ];
  programs = {
    man = {
      enable = true;
      generateCaches = true;
    };
    info.enable = true;
  };
}
