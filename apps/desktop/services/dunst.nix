/*
  Dunst (notification-daemons) conf
*/
{ pkgs, ... }:

{
  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          font = "Noto Sans CJK JP 12";
          min_icon_size = 64;
          min_max_size = 256;
          monitor = 0;
          width = 400;
          height = 50;
          offset = -30;
          origin = "top-left";
          indicate_hidden = false;
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
          context = "ctrl+shift+period";
          history = "ctrl+shift+comma";
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
          right_click = "context";
          notification_limit = 5;
        };
        urgency_low = {
          background = "#222222";
          foreground = "#888888";
          timeout = 12;
        };

        urgency_normal = {
          background = "#222d32";
          foreground = "#cfd8dc";
          timeout = 12;
        };

        urgency_critical = {
          background = "#900000";
          foreground = "#ffffff";
          frame_color = "#ff0000";
          timeout = 0;
        };
      };
    };
  };
}
