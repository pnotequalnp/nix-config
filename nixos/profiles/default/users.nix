{ pkgs, ... }:

{
  users.kevin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "wireshark" ];
    initialPassword = "pass";
  };
}
