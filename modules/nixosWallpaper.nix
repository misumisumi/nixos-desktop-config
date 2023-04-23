{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.xsession.putWallpapers;
in {
  options = {
    xsession.putWallpapers = {
      enable = mkEnableOption ''
        Get wallpaper from nixos-artwork.
      '';
    };
  };
  config = mkIf cfg.enable {
    home = {
      file."${config.home.homeDirectory}/Pictures/wallpapers/fixed/0_main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
      file."${config.home.homeDirectory}/Pictures/wallpapers/fixed/1_main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
      file."${config.home.homeDirectory}/Pictures/wallpapers/unfixed/main.png".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
    };
  };
}