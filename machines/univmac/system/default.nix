{ pkgs, user, ... }:
{
  system.primaryUser = user;
  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
  users.users."${user}" = {
    home = "/Users/${user}";
  };
  homebrew = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    casks = [
      "gimp"
      "google-japanese-ime"
      "krita"
      "microsoft-office"
      "obs"
      "vivaldi"
    ];
  };
}
