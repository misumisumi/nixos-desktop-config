{ pkgs, ... }:

{
  xdg = {
    configFile = {
      "nvim".source = ./nvim;    # windowsとconfigを共有するため.config/nvimで管理する
    };
  };

  programs = {
    neovim = {
      enable = true; # Replace from vi&vim to neovim
      viAlias = true; 
      vimAlias = true;
      vimdiffAlias = true;

      withNodeJs = true;
      withPython3 = true;
      withRuby = true;

      extraPackages = with pkgs; [
        efm-langserver
        rnix-lsp
        black
        pylint
        vim-vint
        yamllint
        nodePackages.diagnostic-languageserver
      ];

      extraPython3Packages = ps: with ps; [
        isort
        docformatter
      ];
    };
  };
}
