{
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
}
