with builtins; {
  xdg = {
    configFile = {
      "starship".source = ./starship;
    };
  };
  programs.starship = {
    enable = true;
    settings = fromTOML (unsafeDiscardStringContext (readFile ./starship/starship.toml));
  };
  programs.zsh.initExtraFirst = ''
    # enable transient prompt for starship
    function zle-line-init starship-line-init {
      emulate -L zsh

      [[ $CONTEXT == start ]] || return 0

      while true; do
        zle .recursive-edit
        local -i ret=$?
        [[ $ret == 0 && $KEYS == $'\4' ]] || break
        [[ -o ignore_eof ]] || exit 0
      done

      local saved_prompt=$PROMPT
      local saved_rprompt=$RPROMPT
      PROMPT='$(STARSHIP_CONFIG=''${XDG_CONFIG_HOME}/starship/starship-transient.toml starship prompt --terminal-width="$COLUMNS" --keymap="''${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="''${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="''${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
      RPROMPT=""
      zle .reset-prompt
      PROMPT=$saved_prompt
      RPROMPT=$saved_rprompt

      if (( ret )); then
        zle .send-break
      else
        zle .accept-line
      fi
      return ret
    }
    _fix_cursor() {
      echo -ne '\e[6 q'
    }
    precmd_functions+=(_fix_cursor)
  '';
}
