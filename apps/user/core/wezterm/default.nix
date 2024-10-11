{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    moralerspace-nerd-fonts
    (nerdfonts.override {
      # Nerdfont override
      fonts = [
        "FiraCode"
      ];
    })
  ];
  programs.wezterm = {
    enable = true;
  };
  xdg.configFile.wezterm = {
    source = ./wezterm;
    recursive = true;
  };
}
