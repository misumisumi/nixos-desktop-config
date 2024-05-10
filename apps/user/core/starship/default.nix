{ config, ... }:
with builtins; {
  xdg = {
    configFile = {
      "starship".source = ./starship;
    };
  };
  programs =
    let
      starshipCmd = "${config.home.profileDirectory}/bin/starship";
    in
    {
      starship = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = false;
        settings = fromTOML (unsafeDiscardStringContext (readFile ./starship/starship.toml));
      };
      # "Do not activate on tty console"
      bash.initExtra = ''
        if [[ $TERM != "dumb" && $TERM != "linux" ]]; then
          eval "$(${starshipCmd} init bash --print-full-init)"
        fi
      '';
      zsh = {
        initExtra = ''
          if [[ $TERM != "dumb" && $TERM != "linux" ]]; then
            eval "$(${starshipCmd} init zsh)"
          fi
        '';
        initExtraFirst = ''
          # enable transient prompt for starship
          function _starship-line-init() {
            [[ $CONTEXT == start ]] || return 0

            # Start regular line editor
            (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[1]
            zle .recursive-edit
            local -i ret=$?
            (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[2]
            local saved_prompt=$PROMPT
            local saved_rprompt=$RPROMPT
            PROMPT='$(STARSHIP_CONFIG=''${XDG_CONFIG_HOME}/starship/starship-transient.toml starship prompt --terminal-width="$COLUMNS" --keymap="''${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="''${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="''${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
            RPROMPT=""
            zle .reset-prompt
            PROMPT=$saved_prompt
            RPROMPT=$saved_rprompt

            # If we received EOT, we exit the shell
            if [[ $ret == 0 && $KEYS == $'\4' ]]; then
                exit
            fi

            # Ctrl-C
            if (( ret )); then
                zle .send-break
            else
                # Enter
                zle .accept-line
            fi
            return ret
          }
          _fix_cursor() {
            echo -ne '\e[6 q'
          }
          precmd_functions+=(_fix_cursor)
          function enable_transientprompt() {
            zle -N zle-line-init _starship-line-init

            # restore broken key bindings
            # https://github.com/JanDeDobbeleer/oh-my-posh/discussions/2617#discussioncomment-3911044
            bindkey '^[[F' end-of-line
            bindkey '^[[H' beginning-of-line
            _widgets=$(zle -la)
            if [[ -n "''${_widgets[(r)down-line-or-beginning-search]}" ]]; then
              bindkey '^[[B' down-line-or-beginning-search
            fi
            if [[ -n "''${_widgets[(r)up-line-or-beginning-search]}" ]]; then
              bindkey '^[[A' up-line-or-beginning-search
            fi
          }
        '';
      };
    };
}
