/*
waydroid (Android emulater) conf
*/
{pkgs, ...}: {
  virtualisation = {
    waydroid = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      weston
      (python3.withPackages (ps: with ps; [pyclip]))
    ];
  };
}
