{ config, lib, pkgs, ... }:

{
  options.profiles.development.haskell = {
    enable = lib.mkEnableOption "Haskell development tooling";
  };

  config = lib.mkIf config.profiles.development.haskell.enable {
    home.packages = with pkgs.haskellPackages;
      let
        ps = p: with p; [ async base containers lens mtl random stm text transformers unliftio ];
        ghc = ghcWithHoogle ps;
      in [
        cabal-install
        ghc
        haskell-language-server
      ];

    home.file = {
      ".ghc/ghci.conf".source = ./ghci.conf;
      ".haskeline".text = "editMode: Vi";
    };

    xdg.configFile."cabal/config".source = ./cabal.config;

    home.sessionVariables = {
      CABAL_DIR = "${config.xdg.dataHome}/cabal";
    };
  };
}
