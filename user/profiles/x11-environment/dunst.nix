{
  enable = true;
  settings = {
    global = {
      geometry = "350x5-10+10";
      separator_height = 4;
      padding = 0;
      horizontal_padding = 8;

      font = "Iosevka Nerd Font 10";
      markup = "full";
      format = "<b>%s</b>\\n%b";
      word_wrap = true;
      show_indicators = false;
      icon_position = "left";
      max_icon_size = 48;
      transparency = 6;

      dmenu = "rofi -dmenu";
      browser = "/usr/bin/env firefox";
    };
    urgency_low = {
      msg_urgency = "low";
      background = "#282c33";
      foreground = "#8c90aa";
    };
    urgency_normal = {
      msg_urgency = "normal";
      background = "#282c33";
      foreground = "#8c90aa";
    };
    urgency_critical = {
      msg_urgency = "critical";
      background = "#282c33";
      foreground = "#8c90aa";
    };
  };
}
