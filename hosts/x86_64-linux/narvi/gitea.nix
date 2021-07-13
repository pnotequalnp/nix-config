{ config, lib, pkgs, ... }:

{
  services.gitea = {
    enable = true;
    appName = "Gitea";
    rootUrl = "https://git.pnotequalnp.com/";
    domain = "git.pnotequalnp.com";
    cookieSecure = true;
    disableRegistration = true;
  };
}
