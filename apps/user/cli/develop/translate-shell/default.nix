{
  programs = {
    bash.historyIgnore = [
      "trans *"
    ];
    zsh.history.ignorePatterns = [
      "trans *"
    ];
    translate-shell = {
      enable = true;
      settings = {
        hl = "ja";
        tl = [
          "en"
        ];
      };
    };
  };
}
