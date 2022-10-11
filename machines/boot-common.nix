{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };

      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
  console = {
    useXkbConfig = true;
  };
}
