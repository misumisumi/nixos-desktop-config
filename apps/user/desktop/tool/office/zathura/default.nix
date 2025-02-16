{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set selection-clipboard clipboard
      set synctex true
      set synctex-editor-command "nvr --remote-silent +%{line} %{input}"
    '';
  };
}
