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
      enableCompletion = false;
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
      envExtra = ''
      '';

      initExtraBeforeCompInit = ''
        # p10k instant prompt
        P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"

        if [[ -r "''${XDG_CACHE_HOME:-''${HOME}/.cache}"/p10k-instant-prompt-"''${(%):-%n}".zsh ]]; then
          source "''${XDG_CACHE_HOME:-''${HOME}/.cache}"/p10k-instant-prompt-"''${(%):-%n}".zsh
        fi
        source "''${XDG_CONFIG_HOME}/zsh/.p10k.zsh"
        autoload -Uz compinit && compinit
        autoload -Uz promptinit
      '';

      initExtra = ''
        zinit ice wait"0"; zi load zdharma-continuum/history-search-multi-word
        zinit ice wait"!0"; zi light zsh-users/zsh-autosuggestions
        zinit ice wait"!0"; zi light zdharma-continuum/fast-syntax-highlighting
        zinit ice wait"!0"; zi load momo-lab/zsh-abbrev-alias
        zinit ice depth=1; zi light jeffreytse/zsh-vi-mode

        zinit snippet PZT::modules/helper/init.zsh
        zinit ice depth=1; zi light romkatv/powerlevel10k

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
