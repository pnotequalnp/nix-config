{ config, lib, pkgs, ... }:

{
  options.profiles.display-server = {
    enable = lib.mkEnableOption "X11 Display Server";
  };

  config = lib.mkIf config.profiles.display-server.enable {
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [ "Iosevka" ];
      })
    ];

    services.xserver = {
      enable = true;
      layout = "us";
      libinput = {
        enable = true;
        mouse = {
          naturalScrolling = true;
          tapping = false;
          accelProfile = "flat";
        };
        touchpad = {
          naturalScrolling = true;
          tapping = false;
          accelProfile = "flat";
        };
      };

      config = ''
        Section "InputClass"
          Identifier "mouse accel"
          Driver "libinput"
          MatchIsPointer "on"
          Option "AccelProfile" "flat"
          Option "AccelSpeed" "0"
        EndSection
      '';

      windowManager.xmonad.enable = true;
    };

    services.kmonad = {
      enable = true;
      configfiles = [ ./keyboard/main.kbd ];
    };
  };
}
