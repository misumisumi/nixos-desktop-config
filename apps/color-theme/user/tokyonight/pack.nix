{ pkgs, ... }:
pkgs.stdenvNoCC.mkDerivation {
  name = "tokyo-night-theme";
  inherit (pkgs.vimPlugins.tokyonight-nvim) src;
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out
    find extras -type d -exec cp -r {} $out \;
  '';
}
