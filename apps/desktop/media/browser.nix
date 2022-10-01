{ pkgs, ... }:

{
  programs = {
    browserpass = {
      enable = true;
      browsers = [
        "firefox"
        "vivaldi"
      ];
    };
  };
}
