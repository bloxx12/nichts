{ pkgs, lib, config, callPackage, ... }:
with lib; let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.i3;
in {
  options.modules.programs.i3.enable = mkEnableOption "i3";

  config = mkIf cfg.enable {
    home-manager.users.${username}.xdg.configFile."i3/config".source = ./config; 
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
