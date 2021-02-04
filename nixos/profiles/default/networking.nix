{ config, lib, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  zerotierone = {
    enable = true;
  };
}
