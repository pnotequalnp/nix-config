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
}
