{ config, lib, pkgs, ... }:

{
  options.programs.exa = {
    enable = lib.mkEnableOption "A modern version of 'ls'";
  };

  config = lib.mkIf config.programs.exa.enable {
    home.packages = [ pkgs.exa ];
  };
}
