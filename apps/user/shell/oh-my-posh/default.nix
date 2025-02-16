{ importJSONFromChezmoi, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    useTheme = "powerlevel10k_classic";
    settings = importJSONFromChezmoi "dot_config/oh-my-posh/config.json";
  };
}
