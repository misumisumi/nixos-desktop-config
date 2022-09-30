{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      history = {
        ignoreDups = true;
        ignorePatterns = [
          "rm *"
          "ls *"
          "pkill *"
          "kill *"
          "history *"
        ];
        save = 10000;
        size = 10000;
        share = true;
      };
      plugins = [
        name = "zsh-abbrev-alias";
        src = pkgs.fetchFromGitHub {
              owner = "mono-lab";
              repo = "zsh-abbrev-alias";
              rev = "33fe094da0a70e279e1cc5376a3d7cb7a5343df5";
              sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
            };
      ];
      initExtra = ''
         source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
         source ${pkgs.zsh-history-search-multi-word-unstable}/share/history-search-multi-word/history-search-multi-word.plugin.zsh
      '';
    };
  };
}
