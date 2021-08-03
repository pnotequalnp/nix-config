{ config, lib, pkgs, ... }:

let tokenFile = "thread_master.token";
in {
  sops.secrets."${tokenFile}" = {
    owner = config.users.users.thread_master.name;
    group = config.users.users.thread_master.group;
  };

  services.thread_master = {
    enable = true;
    tokenFile = config.sops.secrets.${tokenFile}.path;
    channelIDs = [ 686978909132423359 ];
  };
}
