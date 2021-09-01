{ config, lib, pkgs, ... }:

{
  users.users.kevin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.kevin = {
    home.stateVersion = "21.05";

    profiles.terminal.enable = true;
  };

  home-manager.users.root = {
    home.stateVersion = "21.05";

    profiles.terminal.enable = true;
  };
}
