{
  programs = {
    man = {
      enable = true;
      generateCaches = true;
    };
    info.enable = true;
    zsh = {
      sessionVariables = {
        MANPAGER = "less -R --use-color -Dd+c -Du+b";
      };
    };
    bash = {
      sessionVariables = {
        MANPAGER = "less -R --use-color -Dd+c -Du+b";
      };
    };
  };
}
