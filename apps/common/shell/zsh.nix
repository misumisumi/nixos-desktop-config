{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
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
        extraFunctions = [
          "zargs"
          "zmv"
        ];
        extraModules = [
          "attr"
          "history"
          "environment"
          "terminal"
          "editor"
          "directory"
          "spectrum"
          "utility"
          "completion"
        ];
      };

      plugins = [
        {
          name = "zsh-abbrev-alias";
          src = pkgs.fetchFromGitHub {
                owner = "mono-lab";
                repo = "zsh-abbrev-alias";
                rev = "33fe094da0a70e279e1cc5376a3d7cb7a5343df5";
                sha256 = "2193dfab08e9578d7ef0ee41e259b95188f65f2cd0f590b8ccac39f4232f5ee0";
              };
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file="${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "zsh-history-search-multi-word";
          src = pkgs.zsh-history-search-multi-word-unstable;
          file = "${pkgs.zsh-history-search-multi-word-unstable}/share/history-search-multi-word/history-search-multi-word.plugin.zsh";
        }
      ];

      initExtraBeforeCompInit = ''
        # p10k instant prompt
        P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"

        if [[ -r "${XDG_CACHE_HOME:-"''${HOME}"/.cache}/p10k-instant-prompt-"''${(%):-%n}".zsh" ]]; then
          source "${XDG_CACHE_HOME:-"''${HOME}"/.cache}/p10k-instant-prompt-"''${(%):-%n}".zsh"
        fi
      '';

      initExtra = ''
        setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
        setopt inc_append_history    # 履歴をインクリメンタルに追加
      '';
    };
  };
}
