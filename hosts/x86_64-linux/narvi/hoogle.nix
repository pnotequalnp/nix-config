{ config, lib, pkgs, ... }:

let
  cfg = config.services.hoogle;

  hoogleEnv = pkgs.buildEnv {
    name = "hoogle";
    paths = [ (cfg.haskellPackages.ghcWithHoogle cfg.packages) ];
  };
in {
  services.hoogle = {
    enable = true;
    port = 8008;
    home = "https://${config.networking.hostName}/hoogle";
    packages = p: with p; [ conduit unliftio ];
  };

  services.nginx.virtualHosts."${config.networking.hostName}".locations."/hoogle".proxyPass =
    "http://localhost:${toString config.services.hoogle.port}/";

  systemd.services.hoogle.serviceConfig.ExecStart = lib.mkForce
    "${hoogleEnv}/bin/hoogle server --port ${
      toString cfg.port
    } --home ${cfg.home} --host ${cfg.host} --cdn hoogle/";
}
