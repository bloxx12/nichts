{ pkgs, lib, config, callPackage, ... }:
with lib; let
  cfg = config.modules.programs.i3;
in {
  options.modules.programs.i3.enable = mkEnableOption "i3";

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
              LEFT='DP-2'
              CENTER='HDMI-1'
              RIGHT='HDMI-0'
              ${pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --rotate left --output $LEFT --rotate left --left-of $CENTER --output $RIGHT --right-of $CENTER
          '';
# ❯ xrandr --output HDMI-1 --rotate normal --output DP-2 --rotate normal --left-of HDMI-1 --output HDMI-0 --right-of HDMI-1
      };
    };
  };
}
