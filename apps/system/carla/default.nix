{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optional;
in
{
  environment.systemPackages =
    with pkgs;
    [
      yabridge # A modern and transparent way to use Windows VST2 and VST3 plugins on Linux
    ]
    ++ optional config.services.pulseaudio.enable pkgs.carla
    ++ optional config.services.pipewire.enable (
      pkgs.symlinkJoin {
        name = "carla-pw-jack";
        paths = [ pkgs.carla ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/carla \
          --prefix LD_LIBRARY_PATH : ${config.services.pipewire.package.jack}/lib
        '';
      }
    );
}
