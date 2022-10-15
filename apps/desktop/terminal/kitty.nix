{ pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;
      font = {
        package = (pkgs.nerdfonts.override {                   # Nerdfont override
                    fonts = [
                      "FiraCode"
                      "Hack"
                    ];
                  });
        name = "FiraCode Nerd Font";
        size = 14;
      };
      settings = {
        foreground = "#d8e1e6";
        background = "#1f292e";
        background_opacity = 0.85;
      };
    };
  };
}

