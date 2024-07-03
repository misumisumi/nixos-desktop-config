#  Zsh conf
#  I have some plugins problem when managin nix, so I manage zsh plugins from zinit.
#  When you put zinit in nixpkgs, you need to create a symbolic link manually because the path to completions is different.
#  You can watch this solution at (machines/home.nix home.activation.myActivationAction)
{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [ nix-zsh-completions ];
  xdg.configFile = {
    "zsh-abbr/user-abbreviations".source = ./user-abbreviations;
  };
  programs = {
    zsh = {
      enable = true;

      autosuggestion.enable = false;
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
          "trans *"
        ];
        extended = true;
        save = 10000;
        size = 10000;
        share = true;
      };

      prezto = {
        enable = true;
        extraFunctions = [
          "zargs"
          "zmv"
          "zcp"
          "zln"
        ];
        extraModules = [
          "attr"
        ];
      };
      zinit = {
        enable = true;
        promptTheme = {
          enable = false;
          theme = "romkatv/powerlevel10k";
          modifier = ''
            depth=1 atload'P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
            [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
            source "''${HOME}/.p10k.zsh"' light-mode \
          '';
        };
        plugins = {
          # HACK: add ver=${pkgs.zsh-plugin-name.src.rev} and remove depth=1 if you want to fix plugin version.
          "lucid blockf depth=1 light-mode " = [
            "atload'zvm_init'"
            "jeffreytse/zsh-vi-mode"
            "zsh-users/zsh-autosuggestions"
            "marlonrichert/zsh-autocomplete"
          ];
          "wait'0b' lucid nocd depth=1 light-mode" = [
            "olets/zsh-abbr"
          ];
          "wait'!1a' lucid blockf depth=1 light-mode" = [
            "zdharma-continuum/fast-syntax-highlighting"
          ];
          "wait'1b' lucid depth=1 light-mode" = [
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
              # "history"
              "directory"
              "spectrum"
            ];
          };
        };
        initConfig =
          let
            init_fzf = lib.optionalString config.programs.fzf.enable ''
              # Binding keys for zsh-abbr
              if [[ $options[zle] = on ]]; then
                eval "$(${pkgs.fzf}/bin/fzf --zsh)"
              fi
            '';
          in
          ''
            # The plugin will auto execute this zvm_after_init function
            function zvm_after_init() {
                ${init_fzf}
            }
          '';
      };
      shellAliases = {
        nix = "noglob nix";
      };
      localVariables = {
        ZVM_VI_INSERT_ESCAPE_BINDKEY = "jj";
        ZVM_VI_VISUAL_ESCAPE_BINDKEY = "jj";
        ZVM_VI_OPPEND_ESCAPE_BINDKEY = "jj";
        ZVM_LINE_INIT_MODE = "$ZVM_MODE_INSERT";
        ZVM_LAZY_KEYBINDINGS = false;
        ABBR_QUIET = 1;
      };
      # 既にsessionが起動しているかつattach済なら新しくsessionを作成する
      # そうでなればsessionにattachする
      initExtraFirst = ''
        # Calc startup time
        # zmodload zsh/zprof
        # zprof
      '';
      initExtraBeforeCompInit = ''
        setopt EXTENDED_GLOB         # 拡張GRUBの有効化(^: 否定、~: 除外)
        setopt BARE_GLOB_QUAL        # 条件付け検索の有効化
        setopt MAGIC_EQUAL_SUBST     # cmd a=/to/pathの時に補完を効かせる
        setopt HIST_IGNORE_SPACE     # 先頭にスペースがあるコマンドは履歴に残さない
      '';

      initExtra = ''
        # Enable bash completion
        autoload -U bashcompinit && bashcompinit

        set vi-cmd-mode-string "\1\e[?8c\2"
        set vi-ins-mode-string "\1\e[?0c\2"
        # qtileやkittyなどwrap環境内で作業することが必要な時に依存関係のPATHを外す処理
        # (依存関係のPATHが追記された状態を解消してクリーンな状態に戻す)
        # direnvでは問題なかったがnix-shellやnix shellでパスが追記されない
        # (PATH追記後にSHELLが起動するため)問題があったため、シェルの深さで実行の有無を決める
        if [ -n "$DESKTOP_SESSION" ] && [ "$SHLVL" -eq 2 ] || [ "$SHLVL" -eq 1 ]; then
        	PATH=$(echo "$PATH" | sed 's/\/nix\/store\/[a-zA-Z._0-9-]\+\/bin:\?//g' | sed 's/:$//')
        	export PATH="$PATH"
        fi
        # For marlonrichert/zsh-autocomplete
        zstyle -e ':autocomplete:history-search-backward:*' list-lines 'reply=$(( LINES / 2 ))'
        zstyle ':autocomplete:*' min-delay 0.05
        zstyle ':completion:*' completer \
            _complete _complete:-fuzzy _correct _approximate _ignored
        bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
        bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
      '';
    };
  };
}
