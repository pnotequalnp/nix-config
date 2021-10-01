{ config, lib, pkgs, ... }:

{
  options.profiles.development.idris = {
    enable = lib.mkEnableOption "Idris 2 development tooling";
  };

  config = lib.mkIf config.profiles.development.idris.enable {
    home.packages = with pkgs; [
      idris
      idris2
    ] ++ (with pkgs.idris2.packages; [
      lsp
    ]);
  };
}
