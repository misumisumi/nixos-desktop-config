# For

{ pkgs, ... }:
let
  systemPkgs = (import ../system-pkgs);
in
{
  time.timeZone = "Asia/Tokyo";             # Time zone and internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {                 # Extra locale settings that need to be overwritten
      LC_TIME = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts.fonts = with pkgs; [
    noto-Fonts                              # Normal usage
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    rictydiminished-with-firacode           # Programing
    (nerdfonts.override {                   # Nerdfont override
      fonts = [
        "FiraCode"
        "Hack"
        "Terminus"
      ];
    })

    papirus-icon-theme                      # Icons
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = systemPkgs.systemPkgs pkgs ++ systemPkgs.systemWidePythonPkgs pkgs; # 
  };
}
