{ self, lib, ... }:
{
  imports = [
    ./dotfiles.nix
    ./dotnet.nix
    ./qtile.nix
    ./zsh.nix
  ];
  config.lib = {
    ndchm = import ./lib { inherit self lib; };
  };
}
