{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ueberzug 
    ranger.overrideAttrs (r: {
      preConfigure = r.preConfigure + ''
        # Specify path to Überzug
        substituteInPlace ranger/ext/img_display.py \
          --replace "Popen(['ueberzug'" "Popen(['${pkgs.ueberzug}/bin/ueberzug'"

        # Use Überzug as the default method
        substituteInPlace ranger/config/rc.conf \
          --replace 'set preview_images_method w3m' 'set preview_images_method ueberzug'
        '';
        })
    ];
  xdg = {
    configFile = {
      "ranger".source = ./ranger;
    };
  };
}
