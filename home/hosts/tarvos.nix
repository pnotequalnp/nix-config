{ config, lib, pkgs, ... }:

{
  home.stateVersion = "20.09";

  imports = [ ../modules ../profiles ];

  nixpkgs.config.allowUnfree = true;

  profiles = {
    emacs.enable = true;
    graphical.enable = true;
    terminal.enable = true;
    x11-environment.enable = true;

    development = {
      base = {
        enable = true;
        gui = true;
      };
      c.enable = true;
      haskell.enable = true;
      idris.enable = true;
      java.enable = true;
      latex.enable = true;
      rust.enable = true;
    };
  };
}
