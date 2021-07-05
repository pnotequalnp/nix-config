{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.programs.zathura.enable {
    home.packages = [ pkgs.xdotool ];
  };
}
