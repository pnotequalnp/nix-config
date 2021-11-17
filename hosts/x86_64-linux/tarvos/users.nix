{ config, lib, pkgs, ... }:

{
  users.users.kevin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" "wireshark" ];
    initialHashedPassword = "";
  };

  home-manager.users.kevin = {
    home.stateVersion = "21.05";

    profiles = {
      emacs.enable = true;
      graphical.enable = true;
      terminal.enable = true;
      desktop-environment.x11.enable = false;

      development = {
        base.enable = true;
        c.enable = true;
        dhall.enable = true;
        haskell.enable = true;
        idris.enable = true;
        java.enable = true;
        latex.enable = true;
        lean.enable = true;
        rust.enable = true;
      };
    };

    xsession.windowManager.i3 = {
      enable = true;
      config = import ../../../user/profiles/desktop-environment/x11/i3.nix { inherit config lib pkgs; };
    };
  };

  users.users.root.shell = pkgs.zsh;

  home-manager.users.root = {
    home.stateVersion = "21.05";

    profiles.terminal.enable = true;
  };
}
