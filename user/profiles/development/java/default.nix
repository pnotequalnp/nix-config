{ config, lib, pkgs, ... }:

{
  options.profiles.development.java = {
    enable = lib.mkEnableOption "Java development tooling";
  };

  config = lib.mkIf config.profiles.development.java.enable {
    home.sessionVariables = {
      GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
      _JAVA_OPTIONS    = "-Djava.util.prefs.userRoot=${config.xdg.dataHome}/java";
    };
  };
}
