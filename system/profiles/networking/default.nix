{ config, lib, pkgs, ... }:

{
  options.profiles.networking = {
    enable = lib.mkEnableOption "Basic networking";
  };

  config = lib.mkIf config.profiles.networking.enable {
    networking = {
      useDHCP = false;
      networkmanager.enable = true;
    };

    security.pki.certificateFiles = [ ../../../crypto/saturn.crt.pem ];

    services = {
      openssh = {
        enable = true;
        passwordAuthentication = false;
        knownHosts.saturn = {
          hostNames = [ "*" ];
          publicKeyFile = ../../../crypto/saturn.pub;
          certAuthority = true;
        };
        extraConfig = "TrustedUserCAKeys ${../../../crypto/saturn.pub}";
      };

      tailscale.enable = true;
    };
  };
}
