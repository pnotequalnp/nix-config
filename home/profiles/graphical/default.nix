{ config, pkgs, lib, ... }:

{
  options.profiles.graphical = {
    enable = lib.mkEnableOption "Basic GUI tools";
  };

  config = lib.mkIf config.profiles.graphical.enable {
    programs.alacritty = import ./alacritty.nix;
    programs.chromium = import ./chromium.nix;
    programs.firefox = import ./firefox.nix;
    programs.zathura = import ./zathura.nix;

    home.packages = with pkgs; [
      bitwarden
      # discord
      gimp
      inkscape
      mpv
      pavucontrol
      # slack
      sxiv
    ];

    home.sessionVariables = {
      TERM = "xterm-256color";
      TERMINAL = "alacritty";
    };
  };
}
