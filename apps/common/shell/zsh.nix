/*
  Zsh conf
  I have some plugins problem when managin nix, so I manage zsh plugins from zinit.
  When you put zinit in nixpkgs, you need to create a symbolic link manually because the path to completions is different.
  You can watch this solution at (machines/home.nix home.activation.myActivationAction)
*/
{ pkgs, ... }:

{
  home.packages = [ pkgs.nix-zsh-completions ];
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
          file = "share/zinit/zinit.zsh";
        }
      ];
      shellAliases = {
        nix = "noglob nix";
        nixos-rebuild = "noglob nixos-rebuild";
        nixos-install = "noglob nixos-install";
        nixos-container = "noglob nixos-container";
      };

      # initExtraFirst = ''
      #   if [[ -z "$TMUX" ]]; then
      #     tmux new-session
      #     exit
      #   fi
      # '';
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

        # setopt EXTENDED_GLOB         # 拡張GRUBの有効化(^: 否定、~: 除外)
        # setopt BARE_GLOB_QUAL        # 条件付け検索の有効化
        setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
        setopt inc_append_history    # 履歴をインクリメンタルに追加

        ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
        ZVM_VI_VISUAL_ESCAPE_BINDKEY=jj
        ZVM_VI_OPPEND_ESCAPE_BINDKEY=jj
        ZVM_LINE_INIT_MODE=$ZVM_MODE_LAST

        export DIRENV_WARN_TIMEOUT=120s     # DIRENVのタイムアウトまでを長くする
        bindkey -v

        zinit snippet PZT::modules/helper/init.zsh
        zinit ice depth=1; zinit light romkatv/powerlevel10k

        zinit ice silent wait"!0a"; zi light zdharma-continuum/history-search-multi-word
        zinit ice silent wait"!0b"; zi light zdharma-continuum/fast-syntax-highlighting
        zinit ice silent wait"!1a"; zi light zsh-users/zsh-autosuggestions
        zinit ice silent wait"!2a"; zi light hlissner/zsh-autopair
        zinit ice silent depth=1 trigger-load '!zsh-vi-mode'; zi light jeffreytse/zsh-vi-mode
        zinit ice silent depth=1 trigger-load '!zsh-abbr'; zi light olets/zsh-abbr

        # The plugin will auto execute this zvm_after_init function
        function zvm_after_init() {
          # Binding keys for zsh-abbr
          _abbr_bind_widgets
        }


        # historyに元のコマンドが残るalias
        ABBR_QUIET=1
        abbr dene="nix flake new -t github:nix-community/nix-direnv"
        abbr deal="direnv allow"
        abbr venv='source venv/bin/activate'
        abbr tx='tmux'

        # podman and buildah
        abbr p='podman'
        abbr ppl='podman pull'
        abbr ppld='(){podman pull docker.io/$1}'
        abbr pps='podman ps'
        abbr pimgs='podman images'
        abbr prun='podman run'
        abbr bud='buildah bud'

        # git
        abbr g='git'
        abbr ga='git add'
        abbr gc='git commit'
        abbr gac='git add -A && git commit'
        abbr gst='git status'
        abbr gbr='git branch'
        abbr gco='git checkout'
        abbr gdf='git diff'
        abbr gl='git log'
        abbr ggr='git grep'
        abbr gsw='git switch'
        abbr gpl='git pull'
        abbr gpu='git push'
        abbr gget='ghq get'
      '';
    };
  };
}
