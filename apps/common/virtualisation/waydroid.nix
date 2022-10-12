{ pkgs, ... }

{
  virtualisation = {
    waydroid = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      westion
    ];
  };
}
