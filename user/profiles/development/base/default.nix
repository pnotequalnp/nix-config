{ config, lib, pkgs, ... }:

{
  options.profiles.development.base = {
    enable = lib.mkEnableOption "Basic development tooling";
    gui = lib.mkEnableOption "Basic GUI development tooling";
  };

  config = lib.mkIf config.profiles.development.base.enable {
    home.packages = with pkgs; [ binutils docker-compose insomnia scc ];

    inherit (lib.mkIf config.profiles.development.base.gui {
      home.packages = with pkgs; [ insomnia ];
    })
    ;
  };
}
