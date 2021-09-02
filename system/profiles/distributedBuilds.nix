{ config, lib, pkgs, ... }:

{
  options.profiles.distributedBuilds = {
    enable = lib.mkEnableOption "Use remote builders";

    key = lib.mkOption { type = lib.types.path; };
  };

  config = lib.mkIf config.profiles.distributedBuilds.enable {
    distributedBuilds = {
      enable = true;

      key = config.profiles.distributedBuilds.key;

      builders = [{
        hostName = "hyperion";
        system = "aarch64-linux";
        maxJobs = 4;
      }];
    };
  };
}
