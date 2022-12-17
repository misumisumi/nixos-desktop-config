/*
tmux (terminal multiplexer) conf
*/
{ pkgs, ... }:

{
  programs = {
    tmux = {
      enable = true;

      # tmuxのプラグインはリストで渡す
      # tmuxのプラグインはリストで[ tmux-plugin { plugin=tmux-plugin extraConfig="some settings for tmux-plugin" } ]とする
      plugins = with pkgs; [
        tmuxPlugins.sensible

        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-save-interval '10'
          '';
        }
      ];

      prefix = "C-j";

      terminal = "tmux-256color";
      clock24 = true;
      historyLimit = 10000;
      customPaneNavigationAndResize = true;
      keyMode = "vi";
      resizeAmount = 5;
      shell = "${pkgs.zsh}/bin/zsh";

      extraConfig = ''
        set -ag terminal-overrides ",xterm-256color:RGB"
        set -g mouse on

        # setw -g window-active-style fg='#c0c5ce',bg='#2b303b'
        # setw -g window-style fg='#c0c5ce',bg='#27292d'

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

        bind-key i display-panes

        # relox config file
        bind-key r source-file ~/.tmux.conf \; display "Reloaded!"

        unbind s
        bind-key s split-window -v # 水平方向split
        bind-key v split-window -h # 垂直方向split

        run-shell "tmux setenv -g TMUX_VERSION $(tmux -V | cut -c 6-)"

        if-shell -b '[ "$(echo "$TMUX_VERSION < 3.0" | bc)" = 1 ]' "bind-key S choose-tree -s"
        if-shell -b '[ "$(echo "$TMUX_VERSION >= 3.0" | bc)" = 1 ]' "bind-key S choose-tree -Zs"
      '';
    };

  };
}
