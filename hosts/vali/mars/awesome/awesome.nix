{ pkgs, lib, config, callPackage, ... }:
with lib; let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.awesome;
in {
  options.modules.programs.dwm.enable = mkEnableOption "awesome";

  config = mkIf cfg.enable {
      services.xserver = {
      enable = true;
      layout = "de, de";
      xkbVariant = ",neo ";
      xkbOptions = "grp:alt_space_toggle";
      windowManager.awesome = {
          enable = true;
      };
      displayManager = {
          sddm.enable = true;
          setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --rotate normal --output DP-2 --rotate normal --left-of HDMI-1 --output HDMI-0 --right-of HDMI-1";
      };
    };
  };
}
