{ config, lib, pkgs, util, ... }:

{
  system.stateVersion = "21.05";

  imports = [ ./hardware.nix ./users.nix ];

  sops.secrets = util.secretDir null ./secrets;

  profiles = { networking.enable = true; };

  boot.cleanTmpDir = true;

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    hostKeys = [{
      path = config.sops.secrets."ssh_host_ed25519_key".path;
      type = "ed25519";
    }];
    extraConfig = "HostCertificate ${./crypto/ssh_host_ed25519_key-cert.pub}";
  };
}
