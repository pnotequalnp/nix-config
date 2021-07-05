{ config, lib, pkgs, ... }:

{
  options.profiles.development.c = {
    enable = lib.mkEnableOption "C/C++ development tooling";
  };

  config = lib.mkIf config.profiles.development.c.enable {
    home.packages = with pkgs; [
      clang_11
      clang-tools
      cmake
      cmake-language-server
    ];
  };
}
