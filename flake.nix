{
  description = "Nix configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
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
      lib = nixpkgs.lib;
      overlays = [ chrome-dark.overlay emacs-overlay.overlay nur.overlay neovim.overlay ];
      homeConfig = host: {
        name = host;
        value = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          homeDirectory = /home/kevin;
          username = "kevin";
          configuration = { pkgs, ... }: {
            nixpkgs.overlays = overlays;
            imports = [
              (./home/hosts + ("/" + host + ".nix"))
              nix-doom-emacs.hmModule
              emacs-overlay.overlay
            ];
          };
        };
      };
    in {
      homeConfigurations =
        lib.listToAttrs (builtins.map homeConfig [ "tarvos" "minimal" ]);

      nixosConfigurations = {
        tarvos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (_: { nixpkgs.overlays = [ kmonad.overlay ]; })
            ./nixos/hosts/tarvos
            nixpkgs.nixosModules.notDetected
            nixos-hardware.nixosModules.lenovo-thinkpad-t490
            sops-nix.nixosModules.sops
            kmonad.nixosModule
          ];
          extraArgs = { inherit nixpkgs; };
        };
      };

      devShell.x86_64-linux = let
        pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
        xmonadPkgs = import ./home/profiles/x11-environment/xmonad/packages.nix;
      in pkgs.mkShell {
        sopsPGPKeyDirs = [ "./keys" ];
        nativeBuildInputs = [ (pkgs.callPackage sops-nix { }).sops-pgp-hook ];
        buildInputs = with pkgs; [
          (pkgs.haskellPackages.ghcWithHoogle xmonadPkgs)
          sops
        ];
      };
    };
}
