{ config, lib, pkgs, ... }:

{
  options.profiles.development.dhall = {
    enable = lib.mkEnableOption "Dhall development tooling";
  };

  config = lib.mkIf config.profiles.development.dhall.enable {
    home.packages = with pkgs; [ dhall dhall-nix dhall-lsp-server ];
  };
}
