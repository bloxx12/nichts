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
          bspwm.enable = true;
          i3.enable = true;
      };
      displayManager = {
          gdm.enable = true;
          defaultSession = "none+i3";
      };
    };
  };
}
