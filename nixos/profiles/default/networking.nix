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
      extraConfig = "TrustedUserCAKeys ${../../../certs/saturn.pub}";
    };

    tailscale.enable = true;
  };
}
