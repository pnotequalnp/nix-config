{ config, lib, pkgs, util, ... }:

{
  system.stateVersion = "20.03";

  imports = [ ./hardware.nix ./persist.nix ./users.nix ];

  sops.secrets = util.secretDir null ./secrets;

  profiles = {
    display-server.enable = true;
    networking.enable = true;
  };

  networking = {
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  services.openssh = {
    hostKeys = [{
      path = config.sops.secrets."ssh_host_ed25519_key".path;
      type = "ed25519";
    }];
    extraConfig = "HostCertificate ${./crypto/ssh_host_ed25519_key-cert.pub}";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  services = {
    upower.enable = true;
    blueman.enable = true;
    dbus.packages = [ pkgs.gnome3.dconf ];
    pcscd.enable = true;
  };

  sound.enable = true;

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
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
