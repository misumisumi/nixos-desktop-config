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
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # NOTE: homebrew pkgs are managed by nix
    };
    casks = [
      "gimp"
      "karabiner-elements"
      "krita"
      "macSKK"
      "microsoft-office"
      "obs"
      "obsidian"
      "vivaldi"
      "zoom"
    ];
  };
}
