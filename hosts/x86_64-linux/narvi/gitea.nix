{ config, lib, pkgs, ... }:

{
  services.nginx.virtualHosts."${config.networking.hostName}".locations."/git".proxyPass =
    "http://localhost:3000/";

  services.gitea = {
    enable = true;
    appName = "Gitea";
    rootUrl = "https://git.pnotequalnp.com/";
    domain = "git.pnotequalnp.com";
    cookieSecure = true;
    disableRegistration = true;
  };
}
