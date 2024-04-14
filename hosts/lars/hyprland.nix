{ config, lib, inputs, pkgs, ... }:
with lib; let
  username = config.modules.other.system.username;
  cfg = config.modules.hyprland;
in {
    imports = [
      ./waybar.nix
    ];

    options.modules.hyprland.nvidia.enable = mkEnableOption "nvidia";
    options.modules.hyprland = {
        enable = mkEnableOption "hyprland";
	monitor = mkOption {
	    description = "hyprland monitor config";
	    default = ",preferred,auto,1";
	    type = types.listOf(types.str);
	};
	extra = mkOption {
	    description = "any extra configuration to add to the hyprland config file";
	    default = {};
	    type = types.attrs;
	};
    };

  	config = mkIf cfg.enable {
	  	environment.sessionVariables = mkIf cfg.nvidia.enable {
	    LIBVA_DRIVER_NAME = "nvidia";
	    XDG_SESSION_TYPE = "wayland";
	    GBM_BACKEND = "nvidia-drm";
	    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
	    WLR_NO_HARDWARE_CURSORS = "1";
	    SDL_VIDEODRIVER = "wayland";
	    _JAVA_AWT_WM_NONREPARENTING = "1";
	    CLUTTER_BACKEND = "wayland";
	    WLR_RENDERER = "vulkan";
	    XDG_CURRENT_DESKTOP = "Hyprland";
	    XDG_SESSION_DESKTOP = "Hyprland";
	    GTK_USE_PORTAL = "1";
	    NIXOS_XDG_OPEN_USE_PORTAL = "1";
	  };

    programs.hyprland = {
        enable = true;
		xwayland.enable = true;
		};

  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  xdg.portal.lxqt.enable = false;
  systemd.user.services.xdg-desktop-portal-gnome.enable = false;

    home-manager.users.${username} = {
	    wayland.windowManager.hyprland = {
		enable = true;
		settings = lib.mkMerge [{
			# Monitor config
			monitor = cfg.monitor;

			"$mod" = "SUPER";

			input = {
			    kb_layout = "ch";
			};

			bezier = [
			  "wind, 0.05, 0.9, 0.1, 1.05"
			  "winIn, 0.1, 1.1, 0.1, 1.1"
			  "winOut, 0.3, -0.3, 0, 1"
			  "liner, 1, 1, 1, 1"
			];

			animation = [
			    "windows, 1, 6, wind, slide"
			    "windowsIn, 1, 6, winIn, slide"
			    "windowsOut, 1, 5, winOut, slide"
			    "windowsMove, 1, 5, wind, slide"
			    "border, 1, 1, liner"
			    "borderangle, 1, 30, liner, loop"
			    "fade, 1, 10, default"
			    "workspaces, 1, 5, wind"
			];

			exec-once = [
				"waybar"
			];

			bind = [
			    "$mod, Q, killactive"
			    "$mod, return, exec, alacritty"
			    "$mod SHIFT, return, exec, firefox"
			    "$mod SHIFT, m, exit"
			    ", F11, exec, pamixer -d 2"
			    ", F12, exec, pamixer -i 2"
			    "$mod, d, exec, wofi --show drun"

			    # Application
			    "$mod SHIFT, c, exec, code --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu"
			    
			    # Monitor management
			    "$mod SHIFT, k, movecurrentworkspacetomonitor, DP-2"
			    "$mod SHIFT, j, movecurrentworkspacetomonitor, DP-1"

			    # Window Management
			    "$mod, left, movefocus, l"
			    "$mod, right, movefocus, r"
			    "$mod, up, movefocus, u"
			    "$mod, down, movefocus, d"
			    "$mod, F, fullscreen"

			    # Screenshot
			    "$mod SHIFT, s, exec, grim -g '$(slurp -d)' - | wl-copy"
			]
			++ (
			  builtins.concatLists (builtins.genList (
			    x: let
			      ws = let
			        c = (x + 1) / 10;
			      in
			        builtins.toString (x+1-(c * 10));
			    in [
			      "$mod, ${ws}, workspace, ${toString (x+1)}"
			      "$mod SHIFT, ${ws}, movetoworkspace, ${toString(x + 1)}"
			    ]
			  )
			10)
		 );
		} cfg.extra];
	    };
	};
  };

}
