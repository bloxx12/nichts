{ config, lib, inputs, pkgs, ... }:
with lib; let
  username = config.modules.other.system.username;
  cfg = config.modules.waybar;
in {
    options.modules.waybar = {
        enable = mkEnableOption "hyprland";
	};

	config = mkIf cfg.enable {
    	home-manager.users.${username} = {
      		programs.waybar.enable = true;
		};
	};
}
