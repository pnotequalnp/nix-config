{
  enable = true;
  settings = {
    env.TERM = "xterm-256color";

    font = {
      size = 7.5;
      normal.family = "Iosevka Nerd Font";
    };

    colors = {
      primary = {
        background = "#1e2127";
        foreground = "#abb2bf";
      };
      normal = {
        black   = "#1e2127";
        red     = "#e06c75";
        green   = "#98c379";
        yellow  = "#d19a66";
        blue    = "#61afef";
        magenta = "#c678dd";
        cyan    = "#56b6c2";
        white   = "#828791";
      };
      bright = {
        black   = "#5c6370";
        red     = "#e06c75";
        green   = "#98c379";
        yellow  = "#d19a66";
        blue    = "#61afef";
        magenta = "#c678dd";
        cyan    = "#56b6c2";
        white   = "#e6efff";
      };
    };
  };
}
