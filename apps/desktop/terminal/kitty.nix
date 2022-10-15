{ pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;
      font = {
        package = (nerdfonts.override {                   # Nerdfont override
                    fonts = [
                      "FiraCode"
                      "Hack"
                    ];
                  });
        name = "FiraCode Nerd Font";
        size = 14.0;
      };
    };
  };
}

