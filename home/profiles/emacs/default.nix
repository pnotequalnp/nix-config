{ config, lib, pkgs, ... }:

{
  options.profiles.emacs = {
    enable = lib.mkEnableOption "Emacs";
  };

  config = lib.mkIf config.profiles.emacs.enable {
    programs.emacs = {
      enable = true;
      extraPackages = p: with p; [ emacsql-sqlite3 vterm ];
    };

    services.emacs = {
      enable = true;
    };
  };
}
