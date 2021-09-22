{ config, lib, pkgs, ... }:

{
  users.users = {
    kevin = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    builder = {
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles =
        [ ../../x86_64-linux/tarvos/crypto/id_ed25519.pub ];
    };
  };

  home-manager.users.kevin = {
    home.stateVersion = "21.05";

    profiles.terminal = {
      enable = true;
      neovim = false;
    };
  };

  home-manager.users.root = {
    home.stateVersion = "21.05";

    profiles.terminal = {
      enable = true;
      neovim = false;
    };
  };
}
