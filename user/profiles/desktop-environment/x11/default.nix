{ config, lib, pkgs, ... }:

{
  options.profiles.desktop-environment.x11 = {
    enable = lib.mkEnableOption "Desktop environment for an X11 display server";
  };

  config = lib.mkIf config.profiles.desktop-environment.x11.enable {
    xsession = {
      enable = true;

      windowManager.xmonad = {
        enable = true;
        config = ./xmonad/Main.hs;
        extraPackages = import ./xmonad/packages.nix;
      };

      background-image = ./background-image.png;
    };

    services = {
      dunst = import ./dunst.nix;
      picom = import ./picom.nix;
      polybar = import ./polybar.nix { inherit pkgs; };
      unclutter = import ./unclutter.nix;
    };

    programs.rofi = import ./rofi.nix;

    home.packages = with pkgs; [ dunst flameshot iosevka xclip ];

    fonts.fontconfig.enable = true;

    gtk = {
      enable = true;
      theme = {
        package = pkgs.arc-theme;
        name = "Arc-Dark";
      };
    };

    qt.enable = true;

    home.sessionVariables = { _JAVA_AWT_WM_NONREPARENTING = 1; };
  };
}
