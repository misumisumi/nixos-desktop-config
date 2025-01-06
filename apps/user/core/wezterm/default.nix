{
  pkgs,
  chezmoiToNix,
  ...
}:
{
  home.packages = with pkgs; [
    moralerspace-nerd-fonts-alt
    nerd-fonts.fira-code
  ];
  programs.wezterm = {
    enable = true;
  };
  xdg.configFile = chezmoiToNix {
    chezmoiSrc = "dot_config/wezterm";
    recursive = true;
    ignores = [ "color-scheme.lua" ];
  };
}
