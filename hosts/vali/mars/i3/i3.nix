{ pkgs, lib, config, callPackage, ... }:
with lib; let
  cfg = config.myOptions.programs.i3;
in {
  options.myOptions.programs.i3.enable = mkEnableOption "i3";

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb.layout =  "de";
      windowManager = {
          i3.enable = true;
      };
      displayManager = {
          gdm.enable = true;
          defaultSession = "none+i3";
          setupCommands = ''
               xrandr --output HDMI-1 --rotate normal --output DP-2 --rotate normal --left-of HDMI-1 --output HDMI-0 --right-of HDMI-1
          '';
# ❯ xrandr --output HDMI-1 --rotate normal --output DP-2 --rotate normal --left-of HDMI-1 --output HDMI-0 --right-of HDMI-1
      };
    };
  };
}
