{ config, lib, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };

  security.pki.certificateFiles = [ ../../../certs/saturn.crt.pem ];

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
