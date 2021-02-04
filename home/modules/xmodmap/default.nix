{ config, lib, pkgs, ... }:

let
  conf = config.xsession.xmodmap;
  file = pkgs.writeText "xmodmap.conf" conf;
in {
  options.xsession.xmodmap = lib.mkOption {
    type        = lib.types.nullOr lib.types.lines;
    default     = null;
    description = "Custom keymap via xmodmap";
    example     = ''
    '';
  };

  config = lib.mkIf (conf != null) {
    systemd.user.services.xmodmap = {
      Unit = {
        Description = "Custom keymap";
        After       = "graphical-session-pre.target";
        PartOf      = "graphical-session.target";
      };

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.xorg.xmodmap}/bin/xmodmap ${file}";
      };

      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
