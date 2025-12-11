{ pkgs, user, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
  users.users."${user}" = {
    home = "/Users/${user}";
  };
}
