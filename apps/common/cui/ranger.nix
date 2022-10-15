{ pkgs, ... }:
let
ranger = pkgs.ranger.overrideAttrs (r: {
  preConfigure = r.preConfigure + ''
    # Specify path to Überzug
    substituteInPlace ranger/ext/img_display.py \
      --replace "Popen(['ueberzug'" "Popen(['${pkgs.ueberzug}/bin/ueberzug'"

    # Use Überzug as the default method
    substituteInPlace ranger/config/rc.conf \
      --replace 'set preview_images_method w3m' 'set preview_images_method ueberzug'
    '';
  });
in
{
  home.packages = [ pkgs.ueberzug ranger ];
  xdg = {
    configFile = {
      "ranger".source = ./ranger;
    };
  };
}
