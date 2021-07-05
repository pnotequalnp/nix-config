{
  description = "Nix configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/c0e881852006b132236cbf0301bd1939bb50867e";
    nur.url = "github:nix-community/NUR";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kmonad = {
      url = "github:pnotequalnp/kmonad/flake?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
      url = "github:vlaci/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chrome-dark.url = "github:pnotequalnp/chrome-dark";
  };

  outputs = { self, nixpkgs, nur, nixos-hardware, sops-nix, kmonad, home-manager
    , emacs-overlay, nix-doom-emacs, neovim, chrome-dark }:
    let
      inherit (nixpkgs) lib;
      util = import ./util { inherit lib; };
      hmSettings = {
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules =
          [ ./user/modules ./user/profiles nix-doom-emacs.hmModule ];
      };
      overlays = [
        chrome-dark.overlay
        emacs-overlay.overlay
        nur.overlay
        neovim.overlay
      ];
    in {
      homeModules = import ./user/modules;

      genHomeConfiguration = lib.genHomeConfig {
        inherit (hmSettings) sharedModules;
        buildConfig = home-manager.lib.homeManagerConfiguration;
        defaultNixpkgs = nixpkgs.legacyPackages;
        defaultOverlays = overlays;
      };

      nixosModules = import ./system/modules;

      nixosConfigurations = util.genNixosConfigs {
        path = ./hosts;
        extraArgs = {
          inherit nixpkgs util;
          hardware = nixos-hardware.nixosModules;
        };
        sharedModules = [
          { nixpkgs.overlays = overlays; }
          nixpkgs.nixosModules.notDetected
          home-manager.nixosModules.home-manager
          { home-manager = hmSettings; }
          sops-nix.nixosModules.sops
          kmonad.nixosModule
          ./system/profiles
        ];
      };

      devShell.x86_64-linux = let
        pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
        xmonadPkgs = import ./user/profiles/x11-environment/xmonad/packages.nix;
      in pkgs.mkShell {
        buildInputs = with pkgs; [
          (pkgs.haskellPackages.ghcWithHoogle xmonadPkgs)
          sops
        ];
      };
    };
}
