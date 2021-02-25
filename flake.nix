{
  description = "Nix configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
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

  outputs = { self, nixpkgs, nur, nixos-hardware, home-manager, nix-doom-emacs
    , neovim, chrome-dark }:
    let
      lib = nixpkgs.lib;
      overlays = [ chrome-dark.overlay nur.overlay neovim.overlay ];
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
            ./nixos/hosts/tarvos
            nixpkgs.nixosModules.notDetected
            nixos-hardware.nixosModules.lenovo-thinkpad-t490
          ];
          extraArgs = { inherit nixpkgs; };
        };
      };
    };

    nixosConfigurations = {
      tarvos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/tarvos
          nixpkgs.nixosModules.notDetected
          nixos-hardware.nixosModules.lenovo-thinkpad-t490
        ];
      };
    };

    devShell.x86_64-linux =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
        xmonadPkgs = import ./home/profiles/x11-environment/xmonad/packages.nix;
      in pkgs.mkShell {
        buildInputs = with pkgs; [
          (pkgs.haskellPackages.ghcWithHoogle xmonadPkgs)
        ];
      };
  };
}
