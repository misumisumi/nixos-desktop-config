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

    };
  };
}
