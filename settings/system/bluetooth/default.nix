{ lib, config, ... }:
let
  inherit (lib) hasAttr;
in
{
  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket"; # Enable A2DP sink
        };
      };
    };
  };
  services.blueman.withApplet = !hasAttr "home-manager" config;
}
