/*
  neovim conf
  I use conf sourcing ./nvim but you can manager from home manager.
*/
{ config, pkgs, ... }:

{
  xdg = {
    configFile = {
      "nvim".source = ./nvim; # windowsとconfigを共有するため.config/nvimで管理する
    };
  };
  home.sessionVariables = {
    SQLITE_CLIB_PATH = "${pkgs.sqlite.out}/lib/libsqlite3.so";
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
        go
        cargo
        ninja
        gnumake
        gcc # For nvim-treesitter
        # zlib
        patchelf
        sqlite
        yarn

        ripgrep
        silver-searcher # ToDO どっちか消す
      ];

      extraPython3Packages = ps: with ps; [
        isort
        docformatter
        doq
      ];
    };
  };
}
