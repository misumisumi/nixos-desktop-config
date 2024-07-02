{ lib
, pkgs
, scheme
, ...
}:
{
  home.packages = with pkgs; [
    moralerspace-nerd-fonts
  ] ++ lib.optionals (scheme != "core") [
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
  xdg = {
    configFile = lib.mapAttrs'
      (f: _:
        lib.nameValuePair "wezterm/${f}" {
          enable = true;
          source = ./wezterm/${f};
        })
      (builtins.readDir ./wezterm);
  };
}
