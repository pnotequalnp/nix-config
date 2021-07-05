{ config, lib, pkgs, ... }:

{
  users.users.kevin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" "wireshark" ];
    initialHashedPassword = "";
  };

  home-manager.users.kevin = {
    profiles = {
      emacs.enable = true;
      graphical.enable = true;
      terminal.enable = true;
      x11-environment.enable = true;

      development = {
        base = {
          enable = true;
          gui = true;
        };
        c.enable = true;
        haskell.enable = true;
        idris.enable = true;
        java.enable = true;
        latex.enable = true;
        rust.enable = true;
      };
    };
  };
}
