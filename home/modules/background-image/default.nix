{ config, lib, pkgs, ... }:

let
  path = config.xsession.background-image;
in {
  options.xsession.background-image = lib.mkOption {
    type        = lib.types.nullOr lib.types.path;
    default     = null;
    example     = "./background-image";
    description = "Background image via feh";
  };

  config = lib.mkIf (path != null) {
    systemd.user.services.background-image = {
      Unit = {
        Description = "Background image via feh";
        After       = "graphical-session-pre.target";
        PartOf      = "graphical-session.target";
      };

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.feh}/bin/feh --no-fehbg --bg-max ${path}";
      };

      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
