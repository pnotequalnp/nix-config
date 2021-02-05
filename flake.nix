{
  description = "Nix configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chrome-dark.url = "github:pnotequalnp/chrome-dark";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, chrome-dark }: {
    homeConfigurations = {
      tarvos = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = /home/kevin;
        username = "kevin";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = [ chrome-dark.overlay ];
          imports = [ ./home/hosts/tarvos.nix ];
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
  };
}
