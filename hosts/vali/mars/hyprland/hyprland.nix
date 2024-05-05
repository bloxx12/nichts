{ config, pkgs, lib, inputs, ... }: 
with lib;
let 
  cfg = config.modules.programs.hyprland;
  username = config.modules.other.system.username;
  inherit (inputs.hyprland.packages.${pkgs.system}) hyprland;
  inherit (inputs.anyrun.packages.${pkgs.system}) anyrun;
in {
  options.modules.programs.hyprland.enable = mkEnableOption "hyprland";
  config = mkIf cfg.enable {
      
      environment.sessionVariables = {
          XDG_CURRENT_DESKTOP = "Hyprland";
          XDG_SESSION_TYPE = "wayland";
          XDG_SESSION_DESKTOP = "Hyprland";
          SDL_VIDEODRIVER = "wayland";
          CLUTTER_BACKEND = "wayland";
          GDK_BACKEND = "wayland";
          QT_QPA_PLATFORM = "wayland";
          LIBSEAT_BACKEND = "logind";
          WLR_NO_HARDWARE_CURSORS = "1";
          NIXOS_OZONE_WL = "1";
      };

      xdg.portal = {
          enable = true;
          extraPortals = [
              pkgs.xdg-desktop-portal-gtk
              inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
          ];
          config.common.default = "*";
      };
      home-manager.users.${username} = {
          wayland.windowManager.hyprland = {
              enable = true;
              package = inputs.hyprland.packages.${pkgs.system}.hyprland;
              plugins = [
                  inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
              ];
              settings = {
                  "$mainMod" = "SUPER";

                  monitor = [
                  "DP-2,1920x1080,0x0,1"
                  "HDMI-A-2,1920x1080,1920x0,1"
                  "DP-1,1920x1080,3480x0,1" 
                  ];
                  workspace = [

                  ];
                  input = {
                      kb_layout  = "de";
                      kb_variant = "";
                      kb_model   = "";
                      kb_options = "";
                      kb_rules   = "";

                      follow_mouse = true;
                      repeat_rate = 50;
                      repeat_delay = 250;
                      tablet = {
                          output = "HDMI-A-2";
                      };
                  };
                  
                  general = {
                      sensitivity = 1.0;
                      gaps_in = 0;
                      gaps_out = 0;
                      border_size = 2;
                      #"col.active_border" = "0xFFF5C2E7";
                      #"col.inactive_border" = "0xFF45475A";
                  };
                  decoration = {
                      rounding = 0;
                      blur = {
                          enabled = true;
                          size = 3;
                          passes = 2;
                      };
                      drop_shadow = 1;
                      shadow_range = 15;
                      shadow_render_power = 2;
                      shadow_ignore_window = 1;
                      shadow_offset = "2 4";
                      shadow_scale = 1;

                      #"col.shadow" = "0xAF1E1E2E";
                  };
                  bezier = [
                      "dupa, 0.1, 0..9, 0.1, 1.05"
                  ];
                  animations = {
                      enabled = true;
                      animation = [
                          "windows, 1, 4, dupa, popin"
                          "windowsOut, 1, 7, dupa, slide"
                          "border, 1, 15, default"
                          "fade, 1, 10, default"
                          "workspaces, 1, 5, dupa, slidevert"
                      ];
                  };
                  dwindle = {
                      no_gaps_when_only = true;
                  };
                  misc = {
                      enable_swallow = false;
                      swallow_regex = "kitty";
                      focus_on_activate = true;
                      vrr = 1;
                      vfr = true;
                      animate_manual_resizes = false;
                      animate_mouse_windowdragging = false;
                      force_default_wallpaper = 0;
                  };
                  bind = [
                      "$mainMod, RETURN, exec, ${pkgs.kitty}/bin/kitty"
                      "$mainMod, Q, killactive"
                      "$mainMod, D, exec, ${pkgs.procps}/bin/pkill anyrun || ${anyrun}/bin/anyrun"
                      "$mainMod, SPACE, togglefloating, active"
                      # workspaces
                      "$mainMod, 1, split-workspace, 1"
                      "$mainMod, 2, split-workspace, 2"
                      "$mainMod, 3, split-workspace, 3"
                      "$mainMod, 4, split-workspace, 4"
                      "$mainMod, 5, split-workspace, 5"
                      "$mainMod, 6, split-workspace, 6"
                      "$mainMod, 7, split-workspace, 7"
                      "$mainMod, 8, split-workspace, 8"
                      "$mainMod, 9, split-workspace, 9"
                      "$mainMod, 10, split-workspace, 10"
                      "$mainMod SHIFT, 1, split-movetoworkspacesilent, 1"
                      "$mainMod SHIFT, 2, split-movetoworkspacesilent, 2"
                      "$mainMod SHIFT, 3, split-movetoworkspacesilent, 3"
                      "$mainMod SHIFT, 4, split-movetoworkspacesilent, 4"
                      "$mainMod SHIFT, 5, split-movetoworkspacesilent, 5"
                      "$mainMod SHIFT, 6, split-movetoworkspacesilent, 6"
                      "$mainMod SHIFT, 7, split-movetoworkspacesilent, 7"
                      "$mainMod SHIFT, 8, split-movetoworkspacesilent, 8"
                      "$mainMod SHIFT, 9, split-movetoworkspacesilent, 9"
                      "$mainMod SHIFT, 10, split-movetoworkspacesilent, 10"
                  ];
                  binde = [
                      # window focus
                      "$mainMod, H, movefocus, l"
                      "$mainMod, J, movefocus, d"
                      "$mainMod, K, movefocus, k"
                      "$mainMod, L, movefocus, r"

                  ];
                  bindm = [
                      "$mainMod, mouse:272, movewindow"
                      "$mainMod, mouse:273, resizewindow"
                  ];
                  binds = {
                      pass_mouse_when_bound = false;
                      movefocus_cycles_fullscreen = false;
                  };
                  plugin = {
                      split-monitor-workspaces = {
                          count = 10;
                          keep_focused = true;
                      };
                  };
              };
          };
      };
     environment.sessionVariables = {
      /*    LIBVA_DRIVER_NAME = "nvidia";
          XDG_SESSION_TYPE = "wayland";
          GBM_BACKEND = "nvidia-drm";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          SDL_VIDEODRIVER = "wayland";
          _JAVA_AWT_WM_NONREPARENTING = "1";
          CLUTTER_BACKEND = "wayland";
          WLR_RENDERER = "vulkan";
          XDG_CURRENT_DESKTOP = "Hyprland";
          XDG_SESSION_DESKTOP = "Hyprland";
          GTK_USE_PORTAL = "1";
          NIXOS_XDG_OPEN_USE_PORTAL = "1";
          */
     };
     hardware = {
        opengl.enable = true;
        nvidia.modesetting.enable = true;
     };
     environment.systemPackages = with pkgs; [
          (waybar.overrideAttrs (oldAttrs: {
              mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
            }))
          dunst
          libnotify
          hyprpaper
          rofi-wayland
     ];
  };
}

