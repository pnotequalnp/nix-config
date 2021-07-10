{ config, lib, pkgs, ... }:

{
  system.stateVersion = "21.11";

  imports = [ ./hardware.nix ];

  profiles = { };

  boot.loader = {
    systemd-boot.enable = true;
  };

  programs.gnupg.agent.enable = true;
}
