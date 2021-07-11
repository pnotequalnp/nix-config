{ config, lib, pkgs, ... }:

{
  users.users.kevin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" "wireshark" ];
  };

  home-manager.users.kevin = {
    home.stateVersion = "21.05";

    profiles.terminal.enable = true;
  };

  users.users.root.shell = pkgs.zsh;

  home-manager.users.root = {
    home.stateVersion = "21.05";

    profiles.terminal.enable = true;
  };
}
