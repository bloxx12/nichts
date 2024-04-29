{ pkgs, lib, config, callPackage, ... }:
with lib; let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.awesome;
in {
  options.modules.programs.awesome.enable = mkEnableOption "awesome";

  config = mkIf cfg.enable {
      services = {
          displayManager.sddm.enable = true;
          xserver = {
              enable = true;
              xkb = {
                  layout = "de, de";
                  variant = ",neo ";
                  options = "grp:alt_space_toggle";
              };
              windowManager.awesome.enable = true;
              displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --rotate normal --output DP-2 --rotate normal --left-of HDMI-1 --output HDMI-0 --right-of HDMI-1";
          };
      };
  };
}
