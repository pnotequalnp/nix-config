{ config, lib, pkgs, ... }:

let
  cfg = config.programs.neofetch;
in {
  options.programs.neofetch = {
    enable = lib.mkEnableOption
      "A command-line system information tool written in bash 3.2+";
    config = lib.mkOption {
      default = "";
      type = lib.types.lines;
      description = "Configuration options";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.neofetch ];
    xdg.configFile."neofetch/config.conf".text = cfg.config;
  };
}
