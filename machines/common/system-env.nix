# For
{ pkgs, ... }: {
  time.timeZone = "Asia/Tokyo"; # Time zone and internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      # Extra locale settings that need to be overwritten
      LC_TIME = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Source Han Serif" ];
        sansSerif = [ "Source Han Sans" ];
        monospace = [ "Source Han Mono" ];
        # serif = [ "Noto Serif CJK JP" ];
        # sansSerif = [ "Noto Sans CJK JP" ];
        # monospace = [ "Noto Sans Mono CJK JP" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    packages = with pkgs; [
      noto-fonts-emoji
      # noto-fonts # Normal usage
      # noto-fonts-cjk-sans
      # noto-fonts-cjk-serif

      source-han-sans
      source-han-serif
      source-han-mono

      papirus-icon-theme # Icons
    ];
  };
  documentation = {
    man.generateCaches = true;
  };

  environment = {
    variables = {
      TERMINAL = "wezterm";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = import ../../apps/systemWide/pkgs { inherit pkgs; };
  };
}

