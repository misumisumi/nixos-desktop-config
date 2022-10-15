# For

{ pkgs, ... }:
let
  systemPkgs = (import ../system-pkgs);
in
{
  time.timeZone = "Asia/Tokyo";             # Time zone and internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
          "en_US.UTF-8/UTF-8"
          "ja_JP.UTF-8/UTF-8"
        ];
    extraLocaleSettings = {                 # Extra locale settings that need to be overwritten
      LC_TIME = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Source Han Serif" "Noto Serif CJK JP" ];
        sansSerif = [ "Source Han Sans" "Noto Sans CJK JP" ];
        monospace = [ "Source Han Mono" "Noto Sans Mono CJK JP" ];
        emoji = ["Noto Color Emoji"];
      };
    };
    fonts = with pkgs; [
      noto-fonts                              # Normal usage
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      source-han-sans
      source-han-serif
      source-han-mono

      (nerdfonts.override {                   # Nerdfont override
        fonts = [
          "FiraCode"
          "Hack"
          "Terminus"
        ];
      })

      papirus-icon-theme                      # Icons
    ];
  };

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = systemPkgs.systemPkgs pkgs ++ systemPkgs.systemWidePythonPkgs pkgs; # 
  };
}
