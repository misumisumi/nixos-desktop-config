{
  programs = {
    man = {
      enable = true;
      generateCaches = true;
    };
    info.enable = true;
    zsh = {
      sessionVariables = {
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      };
    };
    bash = {
      sessionVariables = {
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      };
    };
  };
}
