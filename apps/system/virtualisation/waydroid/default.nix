/*
  waydroid (Android emulater) conf
*/
{ pkgs, ... }: {
  virtualisation = {
    waydroid = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      weston
      (python3.withPackages (ps: with ps; [ pyclip ]))
      (makeDesktopItem {
        name = "weston";
        exec = "${weston}/bin/weston";
        comment = "A lightweight and functional Wayland compositor";
        desktopName = "Weston";
        categories = [ "System" ];
        type = "Application";
        keywords = [ "shell" ];
      })
    ];
  };
  networking = {
    firewall = {
      trustedInterfaces = [
        "waydroid0"
      ];
    };
  };
}
