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
  };
}
