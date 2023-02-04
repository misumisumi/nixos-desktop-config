/*
  Git conf
*/
{ lib, pkgs, ... }:
with builtins; with lib; let
  lines2list = x: remove "" (map (x: if (match "#.*" x) == null then x else "") x);
  gitignore = splitString "\n" (readFile ./gitignore);
in
{
  home.packages = with pkgs; [ git-ignore ];
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          pager = "${pkgs.delta}/bin/delta --dark --paging=never";
        };
      };
      gui = {
        theme = {
          selectedLineBgColor = [ "default" ];
          selectedRangeBgColor = [ "default" ];
        };
      };
      refresher = {
        refreshInterval = 3;
      };
      os = {
        editCommand = "nvim";
      };
    };
  };
  programs = {
    git = {
      enable = true;
      userEmail = "dragon511southern@gmail.com";
      userName = "Sumi-Sumi";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      ignores = lines2list gitignore;
    };
  };
}
