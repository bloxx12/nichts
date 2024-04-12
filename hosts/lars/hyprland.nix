{ config, inputs, pkgs, ... }:
let
  username = config.myOptions.other.system.username;
in {
    programs.hyprland = {
        enable = true;
	xwayland.enable = true;
    };

    wayland.windowManager.hyprland = {
        enable = true;
	settings = {
		"$mod" = "SUPER";
		bind = [
		    "$mod, Q, killactive"
		    "$mod, return, kitty"
		    "$mod SHIFT, return, firefox"
		];
	};
    };
}
