{
  lib,
  wm,
  ...
}:
{
  imports =
    lib.optionals (wm != "") [
      ../../apps/user/full/programs/firefox.nix
      ../../apps/user/full/programs/vivaldi.nix
    ]
    ++ (import ../../apps/user/full/ime);
}
