with builtins; {
  programs.oh-my-posh = {
    enable = true;
    useTheme = "powerlevel10k_classic";
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./oh-my-posh/config.json));
  };
}
