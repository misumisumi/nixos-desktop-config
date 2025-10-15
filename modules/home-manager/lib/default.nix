{
  self,
  lib,
  ...
}:
{
  chezmoi = import ./chezmoi.nix { inherit self lib; };
}
