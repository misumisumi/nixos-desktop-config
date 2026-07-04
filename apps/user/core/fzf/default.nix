{
  programs = {
    fd.enable = true;
    ripgrep.enable = true;

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = false; # Confilict "jeffreytse/zsh-vi-mode" so init my self
      # ALT+C option
      changeDirWidget.command = "fd --type d";
      changeDirWidget.options = [ "--preview 'tree -C {} | tree -200'" ];
      # CTRL+T option
      fileWidget.command = "fd --type f";
      fileWidget.options = [
        "--preview 'bat -n --color=always {}'"
        "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
      ];
      # CTRL+R option
      historyWidget.options = [
        "--preview 'echo {}' --preview-window up:3:hidden:wrap"
        "--bind 'ctrl-/:toggle-preview'"
        "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
        "--color header:italic"
        "--header 'Press CTRL-Y to copy command into clipboard'"
      ];
    };
  };
}
