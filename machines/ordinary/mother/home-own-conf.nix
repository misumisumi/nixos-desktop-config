{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      evtest
      xp-pen-driver
    ];
  };
}

