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
      };
    };
  };
}
