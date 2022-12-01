/*
neovim conf
I use conf sourcing ./nvim but you can manager from home manager.
*/
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
        gcc              # For nvim-treesitter
        silver-searcher  # ToDO どっちか消す
        ripgrep
        efm-langserver   # Language servers
        rnix-lsp
        nixpkgs-fmt      # use rnix-lsp
        black
        pylint
        vim-vint
        yamllint
        nodePackages.diagnostic-languageserver
      ];

      extraPython3Packages = ps: with ps; [
        isort
        docformatter
        doq
      ];
    };
  };
}
