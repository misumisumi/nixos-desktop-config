with builtins; {
  programs.oh-my-posh = {
    enable = false;
    useTheme = "powerlevel10k_classic";
    settings = fromJSON (unsafeDiscardStringContext (readFile ./oh-my-posh/config.json));
  };
}
