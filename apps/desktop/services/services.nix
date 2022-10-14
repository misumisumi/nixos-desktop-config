{ config, hostname, pkgs, ... }:

{
  services = {
    screen-locker = {
      enable = true;
      inactiveInterval = 40;
      lockCmd = "${pkgs.i3lock}/bin/i3lock -n -t -i ${config.home.homeDirectory}/Pictures/wallpapers/screen_saver.png";

      xautolock = {
        enable = true;
      };
    };

    dunst = {
      enable = true;
      settings = {
        global = {
          monitor = 0;
          geometry = "400x50-30+30";
          indicate_hidden = true;
          transparency = 0;
          separator_height = 2;
          horizontal_padding = 8;
          frame_width = 3;
          frame_color = "#02adc7";
          sort = true;
          markup = "full";
          format = "%a:\\n<b>%s</b>\\n%b";
          alignment = "left";
          show_age_threshold = 60;
          word_wrap = true;
          show_indicators = true;
          sticky_history = true;
        };
        urgency_low = {
          background = "#222222";
          foreground = "#888888";
          timeout = 20;
        };

        urgency_normal = {
          background = "#222d32";
          foreground = "#cfd8dc";
          timeout = 30;
        };

        urgency_critical = {
          background = "#900000";
          foreground = "#ffffff";
          frame_color = "#ff0000";
          timeout = 0;
        };
      };
    };

    picom = {
      enable = if "${hostname}" == "vm" then false else true;
      backend = "glx";
      experimentalBackends = true;
      vSync = false;

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

    blueman-applet = {
      enable = true;
    };

    flameshot = {
      enable = true;
    };

    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}

