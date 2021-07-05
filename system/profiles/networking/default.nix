{ config, lib, pkgs, ... }:

{
  options.profiles.networking = {
    enable = lib.mkEnableOption "Basic networking";
  };

  config = lib.mkIf config.profiles.networking.enable {
    networking = {
      useDHCP = false;
      # nameservers = [ "100.100.100.100" "1.1.1.1" ];
      networkmanager = {
        enable = true;
        # insertNameservers = [ "100.100.100.100" "1.1.1.1" ];
      };
      hosts = { "100.94.36.84" = [ "daphnis" ]; };
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
