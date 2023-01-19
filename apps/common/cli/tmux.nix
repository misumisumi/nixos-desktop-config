/*
  tmux (terminal multiplexer) conf
*/
{ pkgs, ... }:

{
  home.packages = with pkgs; [ xsel bc ];
  programs = {
    tmux = {
      enable = true;

      # tmuxのプラグインはリストで[ tmux-plugin { plugin=tmux-plugin extraConfig="some settings for tmux-plugin" } ]とする
      plugins = with pkgs.tmuxPlugins; [
        sensible
        nord # Theme
        extrakto # complete commands from text in screen
        {
          plugin = tilish; # change tmux like i3wm
          extraConfig = ''
            set -g @tilish-dmenu 'on'
          '';
        }
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-save-interval '10'
          '';
        }
      ];

      prefix = "C-c";
      terminal = "tmux-256color";
      clock24 = true;
      historyLimit = 10000;
      customPaneNavigationAndResize = true;
      keyMode = "vi";
      resizeAmount = 5;
      baseIndex = 1;
      shell = "${pkgs.zsh}/bin/zsh";

      extraConfig = ''
        set -ag terminal-overrides ",xterm-256color:RGB"
        set -g mouse on
        bind-key C-j swap-pane -D
        bind-key C-k swap-pane -U

        setw -g window-active-style fg='#d8e1e6',bg='#1f292e'
        setw -g window-style fg='#d8e1e6',bg='#171e21'

        # Emulate visual-mode in copy-mode of tmux & copy buffer to xsel
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -bi"
        bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xsel -bi"

        bind-key b break-pane
        bind-key q kill-pane
        bind-key C-q kill-session
        #bind-k display-panes\; kill-pane\;
        #bind-k display-panes\; confirm-before kill-pane\;
        bind-key C-x run "tmux kill-pane || tmux kill-window"
        bind-key C-t run "tmux last-pane || tmux last-window || tmux new-window"
        bind-key g popup -w90% -h90% -E lazygit # (prefix) gでlazygitを起動する

        bind-key i display-panes

        # relox config file
        bind-key r source-file ~/.tmux.conf \; display "Reloaded!"

        unbind s
        bind-key s split-window -v # 水平方向split
        bind-key v split-window -h # 垂直方向split

        run-shell "tmux setenv -g TMUX_VERSION $(tmux -V | cut -c 6- | sed -e 's/[a-z]//g')"
        if-shell -b '[ "$(echo "$TMUX_VERSION < 3.0" | bc)" = 1 ]' "bind-key S choose-tree -s"
        if-shell -b '[ "$(echo "$TMUX_VERSION < 3.2" | bc)" = 1 ]' {
            bind-key C-a run-shell "tmux list-sessions | fzf-tmux --reverse | awk -F':' '{print $1}' | xargs tmux switch-client -t"
        }
        if-shell -b '[ "$(echo "$TMUX_VERSION >= 3.0" | bc)" = 1 ]' "bind-key S choose-tree -Zs"
        if-shell -b '[ "$(echo "$TMUX_VERSION >= 3.2" | bc)" = 1 ]' {
            bind-key C-a run-shell "tmux list-sessions | fzf-tmux -p --reverse | awk -F':' '{print $1}' | xargs tmux switch-client -t"
        }

      '';
    };

  };
}
