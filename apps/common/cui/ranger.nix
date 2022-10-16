/*
ranger (CLI Filer) conf
ranger need writable conf dir.
If you want to edit rc.conf (ranger preferences), you muse use nixpkgs override like this.
*/
{ pkgs, ... }:
let
preview4linux = ''
    # Specify path to Überzug
    substituteInPlace ranger/ext/img_display.py \
      --replace "Popen(['ueberzug'" "Popen(['${pkgs.ueberzug}/bin/ueberzug'"

    # Use Überzug as the default method
    substituteInPlace ranger/config/rc.conf \
      --replace 'set preview_images_method w3m' 'set preview_images_method ueberzug'
'';
preview4mac = ''
    # Use kitty as the default method
    substituteInPlace ranger/config/rc.conf \
      --replace 'set preview_images_method w3m' 'set preview_images_method kitty'
'';

ranger = pkgs.ranger.overrideAttrs (r: {
  preConfigure = r.preConfigure + preview4linux;
  });
in
{
  home.packages = [ pkgs.ueberzug ranger ];
  xdg = {
    configFile = {
      "ranger/rifle.conf".source = ./ranger/rifle.conf;
    };
  };
}
