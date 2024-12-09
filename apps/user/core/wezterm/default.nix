{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    moralerspace-nerd-fonts
    nerd-fonts.fira-code
  ];
  programs.wezterm = {
    enable = true;
  };
  xdg.configFile.wezterm = {
    source = ./wezterm;
    recursive = true;
  };
}
