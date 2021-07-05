{ config, lib, pkgs, ... }:

{
  options.profiles.emacs = { enable = lib.mkEnableOption "Doom Emacs"; };

  config = lib.mkIf config.profiles.emacs.enable {
    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom;
    };

    # programs.emacs = {
    # enable = true;
    # package = pkgs.emacsPgtkGcc;
    # };

    services.emacs = { enable = true; };
  };
}
