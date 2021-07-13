{ config, lib, pkgs, ... }:

{
  options.profiles.development.base = {
    enable = lib.mkEnableOption "Basic development tooling";
    gui = lib.mkEnableOption "Basic GUI development tooling";
  };

  config = lib.mkMerge [
    (lib.mkIf config.profiles.development.base.enable {
      profiles.development.base.gui = lib.mkDefault config.profiles.graphical.enable;

      home.packages = with pkgs; [ binutils docker-compose scc ];
    })
    (lib.mkIf config.profiles.development.base.gui {
      home.packages = with pkgs; [ insomnia ];
    })
  ];
}
