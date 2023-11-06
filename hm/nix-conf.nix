{ lib, ... }:
{
  _module.args = {
    pkgs.config.allowUnfree = lib.mkDefault true;
  };
}
