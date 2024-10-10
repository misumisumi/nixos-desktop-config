let
  inherit (builtins) fromJSON unsafeDiscardStringContext readFile;
in
{
  programs.oh-my-posh = {
    enable = false;
    useTheme = "powerlevel10k_classic";
    settings = fromJSON (unsafeDiscardStringContext (readFile ./oh-my-posh/config.json));
  };
}
