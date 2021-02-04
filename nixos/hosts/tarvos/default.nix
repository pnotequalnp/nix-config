{ config, lib, pkgs, ... }:

{
  networking.hostName = "tarvos";
  system.stateVersion = "20.03";

  imports = [
    ../../profiles
    ./hardware-configuration.nix
  ];

  profiles = {
    display-server.enable = true;
  };

  networking = {
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
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
