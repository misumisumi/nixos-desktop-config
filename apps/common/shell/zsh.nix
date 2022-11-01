/*
Zsh conf
I have some plugins problem when managin nix, so I manage zsh plugins from zinit.
When you put zinit in nixpkgs, you need to create a symbolic link manually because the path to completions is different.
You can watch this solution at (machines/home.nix home.activation.myActivationAction)
*/
{ pkgs, ... }:

{
  programs = {
    fzf = {
      enable = true;
    };
    dircolors = {
      enable = true;
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;

      history = {
        ignoreDups = true;
        ignorePatterns = [
          "rm *"
          "ls *"
          "pkill *"
          "kill *"
          "history *"
        ];
        save = 10000;
        size = 10000;
        share = true;
      };

      prezto = {
        enable = true;
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "prompt"
        ];
        extraFunctions = [
          "zargs"
          "zmv"
        ];
        extraModules = [
          "attr"
        ];
      };

      plugins = [
        {
          name = "zinit";
          src = pkgs.zinit;
          file="share/zinit/zinit.zsh";
        }
      ];
      shellAliases = {
        nix = "noglob nix";
        nixos-rebuild = "noglob nix-rebuild";
        nixos-install = "noglob nix-install";
        nixos-container = "noglob nix-container";
      };

      initExtraBeforeCompInit = ''
        # p10k instant prompt
        P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"

        if [[ -r "''${XDG_CACHE_HOME:-''${HOME}/.cache}"/p10k-instant-prompt-"''${(%):-%n}".zsh ]]; then
          source "''${XDG_CACHE_HOME:-''${HOME}/.cache}"/p10k-instant-prompt-"''${(%):-%n}".zsh
        fi
        source "''${XDG_CONFIG_HOME}/zsh/.p10k.zsh"

        declare -A ZINIT
        ZINIT_HOME=''${HOME}/.zinit
        ZINIT[HOME_DIR]=''${ZINIT_HOME}
        [[ -r ''${ZINIT_HOME} ]] || mkdir -p ''${ZINIT_HOME}
      '';

      initExtra = ''
        autoload -Uz promptinit

        autoload -Uz _zinit
        (( ''${+_comps} )) && _comps[zinit]=_zinit

        zinit ice wait"!0c"; zi load zdharma-continuum/history-search-multi-word
        zinit ice wait"!0b"; zi light zsh-users/zsh-autosuggestions
        zinit ice wait"!0a"; zi light zdharma-continuum/fast-syntax-highlighting
        zinit ice wait"!0d"; zi load spwhitt/nix-zsh-completions
        zinit ice wait"!1a"; zi load momo-lab/zsh-abbrev-alias
        zinit ice wait"!1b"; zi load chisui/zsh-nix-shell
        zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

        zinit snippet PZT::modules/helper/init.zsh
        zinit ice depth=1; zinit light romkatv/powerlevel10k

        setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
        setopt inc_append_history    # 履歴をインクリメンタルに追加
        ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
        ZVM_VI_VISUAL_ESCAPE_BINDKEY=jj
        ZVM_VI_OPPEND_ESCAPE_BINDKEY=jj
        ZVM_LINE_INIT_MODE=$ZVM_MODE_LAST
      '';
    };
  };
}
