{ config, lib, pkgs, ... }:

let
  passwordFile = "nextcloud_root_password";
in {
  sops.secrets."${passwordFile}" = {
    owner = config.users.users.nextcloud.name;
    group = config.users.users.nextcloud.group;
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud21;
    hostName = "cloud.pnotequalnp.com";
    https = true;
    config = {
      trustedProxies = [ "127.0.0.1" "[::1]" ];
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      adminpassFile = config.sops.secrets."${passwordFile}".path;
      adminuser = "root";
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [{
      name = "nextcloud";
      ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
    }];
  };

  services.nginx.virtualHosts = {
    "${config.services.nextcloud.hostName}" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 80;
        }
        {
          addr = "[::1]";
          port = 80;
        }
      ];
    };
    "${config.networking.hostName}".locations."/cloud" = {
      proxyPass = "http://localhost/";
      extraConfig =
        "proxy_set_header Host ${config.services.nextcloud.hostName};";
    };
  };

  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
