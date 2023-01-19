/*
  Zsh conf
  I have some plugins problem when managin nix, so I manage zsh plugins from zinit.
  When you put zinit in nixpkgs, you need to create a symbolic link manually because the path to completions is different.
  You can watch this solution at (machines/home.nix home.activation.myActivationAction)
*/
{ pkgs, ... }:

{
  home.packages = with pkgs; [ nix-zsh-completions bat ];
  imports = [ ../../../modules/zinit.nix ];
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = false; # Confilict "jeffreytse/zsh-vi-mode" so init my self
      # ALT+C option
      changeDirWidgetOptions = [
        "--preview 'tree -C {} | tree -200'"
      ];
      # CTRL+T option
      fileWidgetOptions = [
        "--preview 'bat -n --color=always {}'"
        "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
      ];
      # CTRL+R option
      historyWidgetOptions = [
        "--preview 'echo {}' --preview-window up:3:hidden:wrap"
        "--bind 'ctrl-/:toggle-preview'"
        "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
        "--color header:italic"
        "--header 'Press CTRL-Y to copy command into clipboard'"
      ];
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
        extraFunctions = [
          "zargs"
          "zmv"
        ];
        extraModules = [
          "attr"
        ];
        tmux = {
          autoStartLocal = true;
          autoStartRemote = true;
          defaultSessionName = "WS0";
          itermIntegration = true;
        };
      };
      zinit = {
        enable = true;
        promptTheme = {
          theme = "romkatv/powerlevel10k";
          modifier = ''
            depth=1 atload'P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
            [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
            source "''${XDG_CONFIG_HOME}/zsh/.p10k.zsh"' light-mode \
          '';
        };
        plugins = {
          "depth=1 light-mode" = [
            "jeffreytse/zsh-vi-mode"
          ];
          "wait'0b' lucid blockf light-mode" = [
            "zsh-users/zsh-autosuggestions"
            "zsh-users/zsh-completions"
          ];
          "wait'0c' lucid blockf light-mode" = [
            "depth=1 atload'abbr_init' olets/zsh-abbr"
          ];
          "wait'!1a' lucid blockf light-mode" = [
            "zdharma-continuum/fast-syntax-highlighting"
          ];
          "wait'1b' lucid light-mode" = [
            "hlissner/zsh-autopair"
          ];
        };
        prezto = {
          enable = true;
          pmodules = [
            "environment"
            "terminal"
            #"tmux"
          ];
          pmodulesWithModifier = {
            "wait'0a' lucid" = [
              "history"
              "directory"
              "spectrum"
              "completion"
            ];
          };
        };
        initConfig = ''
          # The plugin will auto execute this zvm_after_init function
          function zvm_after_init() {
            # Binding keys for zsh-abbr
            if [[ $options[zle] = on ]]; then
              . ${pkgs.fzf}/share/fzf/completion.zsh
              . ${pkgs.fzf}/share/fzf/key-bindings.zsh
            fi
          }
          # historyに元のコマンドが残るalias
          function abbr_init() {
            abbr_cmds=(
              # virtual env
              diren="nix flake new -t github:nix-community/nix-direnv"
              direal="direnv allow"
              venv='source venv/bin/activate'
              # podman and buildah
              p='podman'
              ppl='podman pull'
              ppld='podman pull docker.io/'
              pps='podman ps'
              pimgs='podman images'
              prun='podman run'
              bud='buildah bud'
              # git
              lg='lazygit'
              g='git'
              ga='git add'
              gc='git commit'
              gac='git add -A && git commit'
              gst='git status'
              gbr='git branch'
              gco='git checkout'
              gdf='git diff'
              gl='git log'
              ggr='git grep'
              gsw='git switch'
              gpl='git pull'
              gpu='git push'
              gget='ghq get'
              # nixos-rebuild
              nixtest='sudo nixos-rebuild test --flake'
              nixswitch='sudo nixos-rebuild switch --flake'
            )
            for cmd in "''${abbr_cmds[@]}"
            do
              abbr $cmd
            done
          }
        '';
      };
      shellAliases = {
        nix = "noglob nix";
        nixos-rebuild = "noglob nixos-rebuild";
        nixos-install = "noglob nixos-install";
        nixos-container = "noglob nixos-container";
      };
      localVariables = {
        ZVM_VI_INSERT_ESCAPE_BINDKEY = "jj";
        ZVM_VI_VISUAL_ESCAPE_BINDKEY = "jj";
        ZVM_VI_OPPEND_ESCAPE_BINDKEY = "jj";
        ZVM_LINE_INIT_MODE = "$ZVM_MODE_INSERT";
        ABBR_QUIET = 1;
      };

      # 既にsessionが起動しているかつattach済なら新しくsessionを作成する
      # そうでなればsessionにattachする
      initExtraFirst = ''
        # Calc startup time
        # zmodload zsh/zprof
        # zprof

        if [[ ! -n $TMUX ]]; then
          tmux start-server
          if ! tmux list-session 2> /dev/null; then
            tmux new-session -s "WS0"
          else
            is_attach=""
            tmux list-sessions | while read line; do
              if [[ $(echo $line | grep "attached") == "" ]]; then
                is_attach=$(echo $line | awk -F':' '{print $1}')
                echo $is_attach
                break
              fi
            done
            if [[ ! $is_attach ]]; then
              tmux new-session
            else
              tmux attach-session -t $is_attach
            fi
          fi
          exit
        fi
      '';
      initExtraBeforeCompInit = ''
        setopt EXTENDED_GLOB         # 拡張GRUBの有効化(^: 否定、~: 除外)
        setopt BARE_GLOB_QUAL        # 条件付け検索の有効化
        setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
        setopt inc_append_history    # 履歴をインクリメンタルに追加
      '';

      initExtra = ''
      '';
    };
  };
}
