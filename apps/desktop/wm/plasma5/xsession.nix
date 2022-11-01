{ config, pkgs, ... }:

{
  home = {
    file."${config.home.homeDirectory}/.background-image".source = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
  };
}
