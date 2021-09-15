{
  description = "Nix configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    chrome-dark.url = "github:pnotequalnp/chrome-dark";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kmonad = {
      url = "github:pnotequalnp/kmonad/flake?dir=nix";
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

    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thread_master = {
      url = "github:pnotequalnp/thread_master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, nixos-hardware, sops-nix, kmonad, home-manager
    , emacs-overlay, nix-doom-emacs, neovim, chrome-dark, deploy-rs
    , thread_master, rnix-lsp }:
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
        (final: prev: { rnix-lsp = rnix-lsp.defaultPackage.${prev.system}; })
      ];
      nixosConfs = util.genNixosConfigs {
        inherit deploy-rs;
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
          thread_master.nixosModule
          ./system/modules
          ./system/profiles
        ];
      };
    in {
      inherit (nixosConfs) nixosConfigurations deploy;

      nixosModules = import ./system/modules;

      homeModules = import ./user/modules;

      genHomeConfiguration = util.genHomeConfig {
        inherit (hmSettings) sharedModules;
        buildConfig = home-manager.lib.homeManagerConfiguration;
        defaultNixpkgs = nixpkgs.legacyPackages;
        defaultOverlays = overlays;
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

      devShell.x86_64-linux = let
        pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
        xmonadPkgs =
          import ./user/profiles/desktop-environment/x11/xmonad/packages.nix;
      in pkgs.mkShell {
        buildInputs = with pkgs; [
          (pkgs.haskellPackages.ghcWithHoogle xmonadPkgs)
          sops
          deploy-rs.defaultPackage.x86_64-linux
        ];
      };
    };
}
