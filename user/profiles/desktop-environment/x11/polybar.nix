{ pkgs }:

let
  bluetoothctl = "${pkgs.bluez}/bin/bluetoothctl";
  rg = "${pkgs.ripgrep}/bin/rg";
  wc = "${pkgs.coreutils}/bin/wc";
  echo = "${pkgs.coreutils}/bin/echo";
  bluetoothMonitor = pkgs.writeScriptBin "bluetoothMonitor" ''
    if [[ $(${bluetoothctl} show | ${rg} 'Powered: yes' | ${wc} -l) -gt 0 ]]; then
      if [[ $(${bluetoothctl} info | ${rg} Device | ${wc} -l) -gt 0 ]]; then
        ${echo} 
      else
        ${echo} 
      fi
    else
      ${echo} "%{F${colors.foreground-alt}}"
    fi
  '';
  colors = {
    background = "#00000000";
    background-alt = "#444";
    foreground = "#dfdfdf";
    foreground-alt = "#777";
    foreground-dim = "#555";
    primary = "#ffb52a";
    warning = "#ff6700";
    alert = "#e60053";
  };
in {
  enable = true;
  package = pkgs.polybarFull;
  script = "polybar primary &";
  config = {
    "bar/primary" = {
      modules-left = "cpu memory filesystem temperature";
      modules-center = "ewmh";
      modules-right = "bluetooth wlan eth battery date";
      font-0 = "Iosevka Nerd Font:size=10;1";
      background = colors.background;
      module-margin-left = 1;
      module-margin-right = 1;
    };

    "module/battery" = {
      type = "internal/battery";
      battery = "BAT0";
      adapter = "AC";
      full-at = 97;
      time-format = "%H:%M";
      label-full = "ﮤ %percentage%%";
      label-charging = "  %percentage%% @%consumption% (%time%)";
      format-discharging = "<ramp-capacity> <label-discharging>";
      label-discharging = "%percentage%% @%consumption% (%time%)";
      ramp-capacity-0 = "%{F${colors.alert}}%{F-} ";
      ramp-capacity-1 = "%{F${colors.warning}}%{F-} ";
      ramp-capacity-2 = " ";
      ramp-capacity-3 = " ";
      ramp-capacity-4 = " ";
    };

    "module/bluetooth" = {
      type = "custom/script";
      exec =
        "${bluetoothMonitor}/bin/bluetoothMonitor ${colors.foreground-alt}";
      interval = 1;
    };

    "module/cpu" = {
      type = "internal/cpu";
      interval = 1;
      format = "<label> <ramp-coreload>";
      label = "%percentage:2%%";
      ramp-coreload-spacing = "0.3";
      ramp-coreload-0 = "▁";
      ramp-coreload-1 = "▂";
      ramp-coreload-2 = "▃";
      ramp-coreload-3 = "▄";
      ramp-coreload-4 = "▅";
      ramp-coreload-5 = "▆";
      ramp-coreload-6 = "%{F${colors.warning}}▇%{F-}";
      ramp-coreload-7 = "%{F${colors.alert}}█%{F-}";
    };

    "module/date" = {
      type = "internal/date";
      interval = 1;
      date = "%a %Y.%m.%d";
      time = "%H:%M:%S";
      label = "%date% %time%";
    };

    "module/ewmh" = {
      type = "internal/xworkspaces";
      enable-click = false;
      enable-scroll = false;
      label-occupied-foreground = colors.foreground-alt;
      label-empty = "";
    };

    "module/eth" = {
      type = "internal/network";
      interface = "enp0s31f6";
      interval = 1;
      label-connected = "";
      label-disconnected = "";
      format-disconnected = "<label-disconnected>";
      label-disconnected-foreground = colors.foreground-alt;
    };

    "module/filesystem" = {
      type = "internal/fs";
      mount-0 = "/";
      format-mounted = "<label-mounted> <ramp-capacity>";
      label-mounted = "%percentage_used%%";
      ramp-capacity-0 = "%{F${colors.alert}}█%{F-}";
      ramp-capacity-1 = "%{F${colors.warning}}▇%{F-}";
      ramp-capacity-2 = "▆";
      ramp-capacity-3 = "▅";
      ramp-capacity-4 = "▄";
      ramp-capacity-5 = "▃";
      ramp-capacity-6 = "▂";
      ramp-capacity-7 = "▁";
    };

    "module/memory" = {
      type = "internal/memory";
      interval = 1;
      format = "<label> <ramp-used>";
      label = "%percentage_used%%";
      ramp-used-0 = "▁";
      ramp-used-1 = "▂";
      ramp-used-2 = "▃";
      ramp-used-3 = "▄";
      ramp-used-4 = "▅";
      ramp-used-5 = "▆";
      ramp-used-6 = "%{F${colors.warning}}▇%{F-}";
      ramp-used-7 = "%{F${colors.alert}}█%{F-}";
    };

    "module/temperature" = {
      type = "internal/temperature";
      interval = 1;
      thermal-zone = 5;
      warn-temperature = 60;
      units = false;
      hwmon-path =
        "/sys/devices/virtual/thermal/thermal_zone5/hwmon3/temp1_input";
      format = "<label>";
      format-warn = "<label-warn>";
      label = "%temperature-c%";
      label-warn = "%temperature-c%";
      label-warn-foreground = colors.alert;
    };

    "module/wlan" = {
      type = "internal/network";
      interface = "wlp0s20f3";
      interval = 3;
      format-connected = "<label-connected>";
      label-connected = "";
      label-disconnected = "";
      format-disconnected = "<label-disconnected>";
      label-disconnected-foreground = colors.foreground-alt;
    };
  };
}
