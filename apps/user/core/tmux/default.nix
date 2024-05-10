{ lib
, pkgs
, ...
}: {
  home.packages = with pkgs; [ xsel bc ];
  programs = {
    fzf = {
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [
          "-p"
          "-w 80%"
          "-h 70%"
        ];
      };
    };
    tmux = {
      enable = true;
      # tmuxのプラグインはリストで[ tmux-plugin { plugin=tmux-plugin extraConfig="some settings for tmux-plugin" } ]とする
      plugins = with pkgs.tmuxPlugins; [
        sensible
        extrakto # complete commands from text in screen
        tmux-fzf
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
        {
          plugin = vim-tmux-navigator;
          extraConfig = ''
            set -g @tilish-navigate 'on'
          '';
        }
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-show-battery false
            set -g @dracula-show-powerline true
            set -g @dracula-show-flags true
            set -g @dracula-show-left-icon session
            set -g @dracula-refresh-rate 5
            set -g @dracula-cpu-usage-label "CPU"
            set -g @dracula-ram-usage-label "RAM"
            set -g @dracula-gpu-usage-label "GPU"
            set -g @dracula-show-timezone false
            set -g @dracula-show-fahrenheit false

            if-shell '[ -z $SSH_CONNECTION ]' {
              set -g @dracula-plugins "time"
              set -g @dracula-time-colors "dark_gray cyan"
            }
            if-shell '[ $SSH_CONNECTION ]' {
              set -g @dracula-plugins "cpu-usage gpu-usage ram-usage time"
              set -g @dracula-time-colors "dark_purple dark_gray"
              set -g @dracula-ram-usage-colors "dark_purple dark_gray"
              set -g @dracula-gpu-usage-colors "dark_gray dark_purple"
              set -g @dracula-cpu-usage-colors "dark_purple dark_gray"
            }
          '';
        }
        {
          plugin = tilish; # change tmux like i3wm
          extraConfig = ''
            set -g @tilish-default 'main-horizontal'
            set -g @tilish-dmenu 'on'
            set -g @tilish-prefix 'C-a'
            bind -T tailish f resize-pane -Z
            bind C-h previous-window
            bind C-l next-window
            bind | split-window -v # 水平方向split
            bind - split-window -h # 垂直方向split
          '';
        }
      ];

      prefix = "C-c";
      terminal = "tmux-256color";
      escapeTime = 10;
      clock24 = true;
      historyLimit = 10000;
      customPaneNavigationAndResize = true;
      keyMode = "vi";
      resizeAmount = 5;
      baseIndex = 1;
      shell = "${pkgs.zsh}/bin/zsh";

      extraConfig = ''
        if-shell '[ $SSH_CONNECTION ]' {
          set -g prefix2 C-b
          bind C-b send-prefix 0
        }
        set -ag terminal-overrides ",xterm-256color:RGB"
        set -s focus-events on
        setw -g xterm-keys on
        set -g mouse on

        setw -g window-active-style fg='#c0caf5',bg='#24283b'
        setw -g window-style fg='#a9b1d6',bg='#1d202f'

        set -g display-panes-time 800 # slightly longer pane indicators display time
        set -g display-time 1000      # slightly longer status messages display time

        set -g status-interval 10     # redraw status line every 10 seconds

        set-hook -g window-pane-changed[0] "set -w main-pane-height 70%"
        set-hook -g window-pane-changed[1] "set -w main-pane-width 75%"
        set-hook -g window-pane-changed[2] "select-layout"
        set-hook -g session-created[2] "select-layout main-horizontal"

        # activity
        set -g monitor-activity on
        set -g visual-activity off

        # Emulate visual-mode in copy-mode of tmux & copy buffer to xsel
        bind -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi C-v send -X rectangle-toggle
        bind -T copy-mode-vi y send -X copy-selection-and-cancel
        bind -T copy-mode-vi Escape send -X cancel
        bind -T copy-mode-vi H send -X start-of-line
        bind -T copy-mode-vi L send -X end-of-line

        bind q kill-pane
        bind C-q kill-session
        bind C-t run "tmux last-pane || tmux last-window || tmux new-window"
        bind g popup -w90% -h90% -E lazygit # (prefix) gでlazygitを起動する

        bind i display-panes

        # reload config file
        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

        run-shell "tmux setenv -g TMUX_VERSION $(tmux -V | cut -c 6- | sed -e 's/[a-z]//g')"
        if-shell -b '[ "$(echo "$TMUX_VERSION < 3.0" | bc)" = 1 ]' "bind S choose-tree -s"
        if-shell -b '[ "$(echo "$TMUX_VERSION < 3.2" | bc)" = 1 ]' {
            bind C-a run-shell "tmux list-sessions | fzf-tmux --reverse | awk -F':' '{print $1}' | xargs tmux switch-client -t"
        }
        if-shell -b '[ "$(echo "$TMUX_VERSION >= 3.0" | bc)" = 1 ]' "bind S choose-tree -Zs"
        if-shell -b '[ "$(echo "$TMUX_VERSION >= 3.2" | bc)" = 1 ]' {
            bind C-a run-shell "tmux list-sessions | fzf-tmux -p --reverse | awk -F':' '{print $1}' | xargs tmux switch-client -t"
        }
      '';
    };
  };
}
