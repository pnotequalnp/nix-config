{ config, lib, pkgs, ... }:

{
  system.stateVersion = "21.11";

  imports = [ ../../profiles ./hardware-configuration.nix ];

  profiles = { };

  networking = {
    hostId = "3e0a674f";
    hostName = "aegaeon";
  };

  programs.gnupg.agent.enable = true;
}
