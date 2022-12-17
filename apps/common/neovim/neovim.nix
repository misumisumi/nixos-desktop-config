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
        black
        efm-langserver   # Language servers
        gcc              # For nvim-treesitter
        nixpkgs-fmt      # use rnix-lsp
        pylint
        ripgrep
        rnix-lsp
        silver-searcher  # ToDO どっちか消す
        vim-vint
        yamllint

        yarn

        luaPackages.lua-lsp
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
