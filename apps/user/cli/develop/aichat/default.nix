{ pkgs, ... }:
{
  home.packages = [ pkgs.aichat ];
  programs.zsh.zinit.plugins = {
    "wait'1c' lucid" = [
      "atload'. ./aichat.zsh' https://raw.githubusercontent.com/sigoden/aichat/main/scripts/completions/aichat.zsh"
    ];
  };
  xdg.configFile."aichat/roles" = {
    source = ./roles;
    recursive = true;
  };
}
