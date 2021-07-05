{ config, lib, pkgs, ... }:

{
  system.stateVersion = "21.11";

  imports = [ ./hardware.nix ];

  profiles = { };

  programs.gnupg.agent.enable = true;
}
