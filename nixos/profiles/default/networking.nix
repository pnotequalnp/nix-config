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
      knownHosts.saturn = {
        hostNames = [ "*" ];
        publicKeyFile = ../../../certs/saturn.pub;
        certAuthority = true;
      };
    };

    tailscale.enable = true;
  };
}
