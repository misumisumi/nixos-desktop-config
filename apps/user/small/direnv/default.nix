{
  home.sessionVariables.DIRENV_WARN_TIMEOUT = "300s"; # DIRENVのタイムアウトまでを長くする
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      nix-direnv = {
        enable = true;
      };
    };
  };
}
