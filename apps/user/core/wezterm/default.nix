{
  lib,
  pkgs,
  scheme,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      moralerspace-nerd-fonts
    ]
    ++ lib.optionals (scheme != "core") [
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
