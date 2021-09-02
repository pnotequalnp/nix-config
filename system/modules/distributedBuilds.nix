{ config, lib, pkgs, util, ... }:

with lib;

let cfg = config.distributedBuilds;
in {
  options.distributedBuilds = {
    enable = mkEnableOption "Use remote builders";

    builders = mkOption {
      default = [ ];
      type = with types;
        listOf (submodule {
          options = {
            hostName = mkOption { type = str; };
            system = mkOption { type = str; };
            maxJobs = mkOption { type = int; };
            sshUser = mkOption {
              type = str;
              default = "builder";
            };
            supportedFeatures = mkOption {
              type = listOf str;
              default = [ "nixos-test" "benchmark" "kvm" "big-parallel" ];
            };
          };
        });
    };

    key = mkOption { type = types.path; };
  };

  config = mkIf cfg.enable {
    nix = {
      distributedBuilds = true;
      buildMachines =
        map (builder: builder // { sshKey = cfg.key; }) cfg.builders;
    };
  };
}
