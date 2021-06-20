{ config, lib, pkgs, ... }:

{
  options.profiles.x11-environment = {
    enable = lib.mkEnableOption
      "xmonad, polybar, picom, dunst, rofi, unclutter, etc.";
  };

  config = lib.mkIf config.profiles.x11-environment.enable {
    xsession = {
      enable = true;

      windowManager.xmonad = {
        enable = true;
        config = ./xmonad/Main.hs;
        extraPackages = import ./xmonad/packages.nix;
      };

      background-image = ./background-image.png;
    };

    services.picom     = import ./picom.nix;
    services.dunst     = import ./dunst.nix;
    services.unclutter = import ./unclutter.nix;
    programs.rofi      = import ./rofi.nix;

    services.polybar = import ./polybar.nix { inherit pkgs; };

    home.packages = with pkgs; [ flameshot xclip dunst ];

    gtk = {
      enable = true;
      theme = {
        package = pkgs.arc-theme;
        name = "Arc-Dark";
      };
    };

    qt = {
        enable = true;
        # platformTheme = "gtk";
      };

    home.sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = 1;
    };
  };
}
