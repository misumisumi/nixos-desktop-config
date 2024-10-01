# Dunst (notification-daemons) conf
{ pkgs, ... }:
{
  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          font = "Noto Sans CJK JP 12";
          min_icon_size = 32;
          max_icon_size = 128;
          monitor = 0;
          width = 400;
          height = 200;
          enable_posix_regex = true;
          offset = "-30+30";
          origin = "top-right";
          indicate_hidden = false;
          transparency = 0;
          separator_height = 2;
          horizontal_padding = 8;
          frame_width = 3;
          sort = true;
          markup = "full";
          format = "%a:\\n<b>%s</b>\\n%b";
          alignment = "left";
          show_age_threshold = 60;
          word_wrap = true;
          show_indicators = true;
          sticky_history = true;
          context = "ctrl+shift+period";
          history = "ctrl+shift+comma";
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
          right_click = "context";
          notification_limit = 5;
        };
        urgency_low = {
          timeout = 8;
        };

        urgency_normal = {
          timeout = 8;
        };

        urgency_critical = {
          timeout = 0;
        };
        vivaldi-stable = {
          appname = "Input Method";
          format = "";
          urgency = "low";
        };
      };
    };
  };
}
