{ sources ? import ../../../nix/sources.nix, pkgs ? import sources.nixpkgs-unstable {} }:

let
  hs = pkgs.haskellPackages;
  hsPkgs = import ./packages.nix;
in pkgs.mkShell {
  buildInputs = with pkgs; with hs; [
    (ghcWithHoogle hsPkgs)
  ];
}
