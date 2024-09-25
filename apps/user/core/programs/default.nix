{
  programs = {
    bat = {
      enable = true;
      config = {
        map-syntax = [ ];
        style = "numbers,changes,header";
        pager = "less -FR";
      };
    };
    dircolors.enable = true;
    fd.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
  };
}
