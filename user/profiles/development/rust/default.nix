{ config, lib, pkgs, ... }:

{
  options.profiles.development.rust = {
    enable = lib.mkEnableOption "Rust development tooling";
  };

  config = lib.mkIf config.profiles.development.rust.enable {
    home.packages = with pkgs; [
      rust-analyzer
      rustfmt
    ];
  };
}
