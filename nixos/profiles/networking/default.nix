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
  };
}
