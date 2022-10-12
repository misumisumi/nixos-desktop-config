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
      enableSyntaxHighlighting = true;
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
          name = "zsh-abbrev-alias";
          src = pkgs.fetchFromGitHub {
                owner = "momo-lab";
                repo = "zsh-abbrev-alias";
                rev = "33fe094da0a70e279e1cc5376a3d7cb7a5343df5";
                sha256 = "1cvgvb1q0bwwnnvkd7yjc7sq9fgghbby1iffzid61gi9j895iblf";
              };
          file = "addrev-alias.plugin.zsh";
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file="share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "zsh-history-search-multi-word";
          src = pkgs.zsh-history-search-multi-word;
          file="share/zsh/zsh-history-search-multi-word/history-search-multi-word.plugin.zsh";
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

        # if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
        #     sh -c "$(curl -fsSL https://git.io/get-zi)" --
        # fi
        # source "$HOME/.zi/bin/zi.zsh"
      '';

      initExtra = ''
        autoload -Uz compinit && compinit
        autoload -Uz promptinit

        if [[ -f "$HOME/.config/zsh/plugins/zsh-history-search-multi-word/share/zsh/zsh-history-search-multi-word/history-search-multi-word.plugin.zsh" ]]; then
          source $HOME/.config/zsh/plugins/zsh-history-search-multi-word/share/zsh/zsh-history-search-multi-word/history-search-multi-word.plugin.zsh
        fi
        bindkey "^R" history-search-multi-word

        # zi ice wait"0"; zi load zdharma-continuum/history-search-multi-word
        # zi ice wait"!0"; zi light zsh-users/zsh-autosuggestions
        # zi ice wait"!0"; zi light zdharma-continuum/fast-syntax-highlighting
        # zi ice wait"!0"; zi load momo-lab/zsh-abbrev-alias
        # zi ice depth=1; zi light jeffreytse/zsh-vi-mode

        # zi snippet PZT::modules/helper/init.zsh
        # zi ice depth=1; zi light romkatv/powerlevel10k

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
