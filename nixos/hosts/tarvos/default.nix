{ config, lib, pkgs, ... }:

{
  system.stateVersion = "20.03";

  imports = [
    ../../profiles
    ./persist.nix
    ./hardware-configuration.nix
    ./secrets
  ];

  profiles = { display-server.enable = true; };

  networking = {
    hostId = "745c9bc3";
    hostName = "tarvos";

    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  services.openssh = {
    hostKeys = [{
      path = config.sops.secrets.tarvos_ssh_host_ed25519_key.path;
      type = "ed25519";
    }];
    extraConfig = "HostCertificate ${
        config.sops.secrets."tarvos_ssh_host_ed25519_key-cert.pub".path
      }";
  };

  systemd.services.muteLight = {
    description = "Disable mute light";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/echo 0";
      StandardOutput = "file:/sys/class/leds/platform::mute/brightness";
    };
  };
}
