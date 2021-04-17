{ config, lib, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };

  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
    };

    tailscale.enable = true;
  };
}
