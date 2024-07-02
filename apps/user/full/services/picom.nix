# Picom (compositor for Xorg) conf
{ pkgs, ... }: {
  services = {
    picom = {
      enable = true;
      package = pkgs.picom-next;
      backend = "glx";
      vSync = false; # When vSync=true, Picom have problem if you use Nvidia

      fade = true;
      fadeDelta = 10;
      fadeSteps = [ 0.06 0.06 ];

      activeOpacity = 0.75;
      inactiveOpacity = 0.75;
      opacityRules = [
        "100:class_g = 'alacritty' && focused"
        "100:class_g = 'alacritty' && !focused"
        "100:class_g = 'kitty' && focused"
        "100:class_g = 'kitty' && !focused"
        "100:class_g = 'org.wezfurlong.wezterm' && focused"
        "100:class_g = 'org.wezfurlong.wezterm' && !focused"
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
        "100:class_g = 'PenTablet' && focused"
        "100:class_g = 'PenTablet' && !focused"
        "100:class_g = 'Looking Glass (client)' && focused"
        "100:class_g = 'Looking Glass (client)' && !focused"
        "100:class_g = 'Picture in picture' && focused"
        "100:class_g = 'Picture in picture' && !focused"
        "100:name = 'masterduel' && focused"
        "100:name = 'masterduel' && !focused"
        "100:name = 'WaveSurer 1.8.8.p5' && focused"
        "100:name = 'WaveSurer 1.8.8.p5' && !focused"
        "100:name = 'i3lock' && focused"
        "100:name = 'i3lock' && !focused"
        "100:name *?= 'Youtube'"
        "100:name *?= 'Prime Video'"
        "100:name *?= 'ニコニコ動画'"
        "100:name *?= '.pdf'"
        "100:name *?= '.jpg'"
        "100:name *?= '.png'"
      ];

      shadow = true;
      shadowExclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "_GTK_FRAME_EXTENTS@:c"
        "class_g = 'rofi'"
        "class_g = 'Conky'"
        "class_g = 'Cairo-clock'"
        "class_g = 'dunst'"
        "class_g = 'rofi'"
        "class_g = 'kdeconnectd'"
        "class_g = 'kdeconnect-handler'"
        "class_g = 'kdeconnect-indicator'"
        "class_g = 'kdeconnect-sms'"
        "class_g = 'kdeconnect-sms-handler'"
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
        blur-method = "dual_kawase";
        blur-size = 8;
        blur-strength = 6;
        blur-background = false;
        blur-background-frame = false;
        blur-bluer-kern = "3x3box";
        blur-background-exclude = [
          "class_g = 'kdeconnectd && !focused'"
          "_NET_WM_NAME@:s *= 'KDE Connect Daemon'"
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
        mark-wmwin-focused = true;
        mark-overdir-focused = false;
        detect-rounded-corners = false;
        detect-client-opacity = true;
        detect-transient = true;
        glx-no-stencil = true;
        glx-no-rebind-pixmap = true;
        use-damage = false;
        xrender-sync-fence = true;
      };
    };
  };
}
