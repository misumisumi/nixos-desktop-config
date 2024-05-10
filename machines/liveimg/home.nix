{ lib
, wm
, ...
}:
{
  imports = lib.optionals (wm != "") [
    ../../apps/full/programs/firefox.nix
    ../../apps/full/programs/vivaldi.nix
  ]
  ++ (import ../../apps/full/ime)
  ;
}
