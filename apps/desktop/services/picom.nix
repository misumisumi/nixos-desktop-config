/*
Picom (compositor for Xorg) conf
*/
{ pkgs, ... }:

{
  services = {
    picom = {
      enable = true;
      backend = "glx";
      experimentalBackends = true;  # enable blur and rounded corner
      vSync = false;  # When vSync=true, Picom have problem if you use Nvidia 

      fade = true;
      fadeDelta = 10;
      fadeSteps = [ 0.06 0.06 ];

      activeOpacity = 0.75;
      inactiveOpacity = 0.75;
      opacityRules = [
        "85:class_g = 'kitty' && focused"
        "85:class_g = 'kitty' && !focused"
        "85:class_g = 'alacritty' && focused"
        "85:class_g = 'alacritty' && !focused"
        "100:class_g = 'krita' && focused"
        "100:class_g = 'krita' && !focused"
        "100:class_g = 'Blender' && focused"
        "100:class_g = 'Blender' && !focused"
        "100:class_g = 'Unity' && focused"
        "100:class_g = 'Unity' && !focused"
        "100:class_g = 'fcitx' && focused"
        "100:class_g = 'fcitx' && !focused"
        "100:class_g = 'pentablet' && focused"
        "100:class_g = 'pentablet' && !focused"
        "100:name = 'masterduel' && focused"
        "100:name = 'masterduel' && !focused"
        "100:name = 'WaveSurer 1.8.8.p5' && focused"
        "100:name = 'WaveSurer 1.8.8.p5' && !focused"
        "100:name = 'i3lock' && focused"
        "100:name = 'i3lock' && !focused"
      ];

      shadow = true;
      shadowExclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "_GTK_FRAME_EXTENTS@:c"
        "class_g = 'rofi'"
      ];
      shadowOffsets = [ (-7) (-7) ];
      shadowOpacity = 0.75;

      settings = {
        shadow-radius = 16;
        frame-opacity = 0.8;
        corner-radius = 16;
        rounded-corners-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "class_g = 'fcitx'"
          "class_g = 'dunst'"
        ];
        blur = {
          method = "dual_kawase";
          size = 8;
          strength = 5;
          background = true;
          background-frame = true;
          bluer-kern = "3x3box";
          background-exclude = [
            "window_type = 'dock'"
            "window_type = 'desktop'"
            "_GTK_FRAME_EXTENTS@:c"
          ];
        mark-wmwin-focused = true;
        mark-overdir-focused = false;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-transient = true;
        glx-no-stencil = true;
        glx-no-rebind-pixmap = true;
        use-damage = true;
        xrender-sync-fence = true;
        };
      };
    };
  };
}
