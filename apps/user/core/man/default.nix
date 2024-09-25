{
  home.shellAliases = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };
  programs = {
    man = {
      enable = true;
      generateCaches = true;
    };
    info.enable = true;
  };
}
