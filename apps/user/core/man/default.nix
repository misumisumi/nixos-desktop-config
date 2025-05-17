{
  #NOTE: https://github.com/sharkdp/bat/issues/2568
  home.sessionVariablesExtra = ''
    export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'";
  '';

  programs = {
    bat = {
      enable = true;
      config = {
        map-syntax = [ ];
        style = "numbers,changes,header";
        pager = "less -FR";
      };
    };
    man = {
      enable = true;
      generateCaches = true;
    };
    info.enable = true;
    lesspipe.enable = true;
  };
}
