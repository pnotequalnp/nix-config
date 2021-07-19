{ config, lib, pkgs, ... }:

{
  options.profiles.development.lean = {
    enable = lib.mkEnableOption "Lean development tooling";
  };

  config = lib.mkIf config.profiles.development.lean.enable {
    home.packages = with pkgs; [ lean ];
  };
}
