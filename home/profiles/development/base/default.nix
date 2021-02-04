{ config, lib, pkgs, ... }:

{
  options.profiles.development.base = {
    enable = lib.mkEnableOption "Basic development tooling";
  };

  config = lib.mkIf config.profiles.development.base.enable {
    programs.vscode = import ./vscodium.nix { inherit config lib pkgs; };

    home.packages = with pkgs; [
      binutils
      docker-compose
      insomnia
      scc
    ];
  };
}
