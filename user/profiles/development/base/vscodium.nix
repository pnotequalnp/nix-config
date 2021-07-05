{ config, pkgs, lib, ... }:

{
  enable = true;
  package = pkgs.vscodium;
  extensions = [ pkgs.vscode-extensions.bbenoist.Nix ];
}
