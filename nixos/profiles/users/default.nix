{ config, lib, pkgs, ... }:

{
  options.profiles.users = {
    enable = lib.mkEnableOption "Default user settings";
  };

  config = lib.mkIf config.profiles.users.enable {
    users = {
      mutableUsers = true;

      users.kevin = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups =
          [ "wheel" "networkmanager" "docker" "vboxusers" "wireshark" ];
        initialHashedPassword = "";
      };
    };
  };
}
