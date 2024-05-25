{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.wms.wayland.hyprland;
  username = config.modules.other.system.username;
  inherit (inputs.hyprland.packages.${pkgs.system}) hyprland;
  inherit (inputs.anyrun.packages.${pkgs.system}) anyrun;
  inherit
    (inputs.nixpkgs-wayland.packages.${pkgs.system})
    foot
    swww
    wlsunset
    ;
  inherit (inputs.waybar.packages.${pkgs.system}) waybar;
  inherit
    (inputs.split-monitor-workspaces.packages.${pkgs.system})
    split-monitor-workspaces
    ;
in {
  options.modules.wms.wayland.hyprland.enable = lib.mkEnableOption "hyprland";
  config = lib.mkIf cfg.enable {
    # xdg Portal
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
        package = hyprland;
        # Split-monitor-workspaces provides awesome-like workspace behaviour
        plugins = [
          split-monitor-workspaces
        ];
        # Xwayland for X applications
        xwayland.enable = true;
        # No idea why I set this
        systemd = {
          enable = true;
          variables = ["--all"];
        };

        # Hyprland settings
        settings = {
          "$mainMod" = "SUPER";

          # Monitor config
          monitor = [
            #"eDP-1,1920x1080,0x0,1"
            "DP-2,1920x1080,0x0,1"
            "HDMI-A-2,1920x1080,1920x0,1"
            "HDMI-A-1,1920x1080,3840x0,1"
            # Had the shadow monitor bug, so had to disable all unknown monitors.
            "Unknown-1,disable"
          ];
          # Workspace config
          workspace = [
            #"1, monitor:eDP-1, default:true"
            #"2, monitor:eDP-1"
            #"3, monitor:eDP-1"
            #"4, monitor:eDP-1"
            #"5, monitor:eDP-1"
            #"6, monitor:eDP-1"
            #"7, monitor:eDP-1"
            #"8, monitor:eDP-1"
            #"9, monitor:eDP-1"
            #"10, monitor:eDP-1"

            "1,monitor:HDMI-A-1, default:true"
            "2,monitor:HDMI-A-1"
            "3,monitor:HDMI-A-1"
            "4,monitor:HDMI-A-1"
            "5,monitor:HDMI-A-1"
            "6,monitor:HDMI-A-1"
            "7,monitor:HDMI-A-1"
            "8,monitor:HDMI-A-1"
            "9,monitor:HDMI-A-1"
            "10,monitor:HDMI-A-1"

            "11, monitor:HDMI-A-2, default:true"
            "12, monitor:HDMI-A-2"
            "13, monitor:HDMI-A-2"
            "14, monitor:HDMI-A-2"
            "15, monitor:HDMI-A-2"
            "16, monitor:HDMI-A-2"
            "17, monitor:HDMI-A-2"
            "18, monitor:HDMI-A-2"
            "19, monitor:HDMI-A-2"
            "20, monitor:HDMI-A-2"

            "21, monitor:DP-2, default:true"
            "22, monitor:DP-2"
            "23, monitor:DP-2"
            "24, monitor:DP-2"
            "25, monitor:DP-2"
            "26, monitor:DP-2"
            "27, monitor:DP-2"
            "28, monitor:DP-2"
            "29, monitor:DP-2"
            "30, monitor:DP-2"

            # scratchpads
            "special:btop, decorate:false"
            "special:pipewire, decorate:false"
            "special:nixos, decorate:false"
            "special:keepassxc, decorate:false"
          ];
          # Input settings
          input = {
            kb_layout = "de";
            kb_variant = "";
            kb_model = "";
            kb_options = "";
            kb_rules = "";

            follow_mouse = true;
            repeat_rate = 50;
            repeat_delay = 250;
          };
          general = {
            sensitivity = 1.0;
            gaps_in = 4;
            gaps_out = 10;
            border_size = 2;
          };
          #Decoration settings
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
          };
          # Bezier curves for aninmations.
          # Generate your own at https://www.cssportal.com/css-cubic-bezier-generator/
          bezier = [
            "dupa, 0.1, 0.9, 0.1, 1.05"
            "apf,0.76,0,0.24,1"
            "fast,0.34,1.56,0.64,1"
          ];
          # Hyprland anomations, using the above bezier curves
          animations = {
            enabled = false;
            animation = [
              "windows, 1, 4, dupa, popin"
              "windowsOut, 1, 4, dupa, slide"
              "border, 1, 15, default"
              "fade, 1, 10, default"
              "workspaces, 1, 5, dupa, slidevert"
            ];
          };
          dwindle = {no_gaps_when_only = true;};

          debug.disable_logs = false;

          misc = {
            enable_swallow = true;
            swallow_regex = "foot";
            focus_on_activate = true;
            vrr = 1;
            vfr = true;
            animate_manual_resizes = false;
            animate_mouse_windowdragging = false;
            force_default_wallpaper = 0;
          };
          # Window rules for some programs.
          windowrulev2 = [
            "float, class:^(Tor Browser)$"
            "float, class:^(mpv)$"
            "float, class:^(imv)$"
            "float, title:^(Picture-in-Picture)$"
            "float, title:^(.*)(Choose User Profile)(.*)$"
            "float, title:^(blob:null/)(.*)$"
            "float, class:^(xdg-desktop-portal-gtk)$"
            "float, class:^(code), title: ^(Open*)"
            "size 70% 70%, class:^(code), title: ^(Open*)"
            "center, class: ^(code), title: ^(Open*)"
            "float, class:^(org.keepassxc.KeePassXC)$"
          ];
          # Keybinds
          bind = [
            "$mainMod, RETURN, exec, ${foot}/bin/foot -D ~"
            "$mainMod, Q, killactive"
            "$mainMod, F, fullscreen, 0"
            "$mainMod, D, exec, ${pkgs.procps}/bin/pkill anyrun || ${anyrun}/bin/anyrun"
            "$mainMod, SPACE, togglefloating, active"
            "$mainMod, O, exec, obsidian --ozone-platform=wayland --enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --enable-features=WebRTCPipeWireCpaturer --disable-gpu"
            # workspaces
            # split-workspace is because of the split-workspace plugin
            "$mainMod, 1, split-workspace, 1"
            "$mainMod, 2, split-workspace, 2"
            "$mainMod, 3, split-workspace, 3"
            "$mainMod, 4, split-workspace, 4"
            "$mainMod, 5, split-workspace, 5"
            "$mainMod, 6, split-workspace, 6"
            "$mainMod, 7, split-workspace, 7"
            "$mainMod, 8, split-workspace, 8"
            "$mainMod, 9, split-workspace, 9"
            "$mainMod, 0, split-workspace, 10"
            "$mainMod SHIFT, 1, split-movetoworkspacesilent, 1"
            "$mainMod SHIFT, 2, split-movetoworkspacesilent, 2"
            "$mainMod SHIFT, 3, split-movetoworkspacesilent, 3"
            "$mainMod SHIFT, 4, split-movetoworkspacesilent, 4"
            "$mainMod SHIFT, 5, split-movetoworkspacesilent, 5"
            "$mainMod SHIFT, 6, split-movetoworkspacesilent, 6"
            "$mainMod SHIFT, 7, split-movetoworkspacesilent, 7"
            "$mainMod SHIFT, 8, split-movetoworkspacesilent, 8"
            "$mainMod SHIFT, 9, split-movetoworkspacesilent, 9"
            "$mainMod SHIFT, 0, split-movetoworkspacesilent, 10"

            # Move Windows
            "$mainMod SHIFT, H, movewindow, l"
            "$mainMod SHIFT, J, movewindow, d"
            "$mainMod SHIFT, K, movewindow, u"
            "$mainMod SHIFT, L, movewindow, r"
            # Screenshotting
            "$mainMod, S, exec, ${pkgs.grimblast}/bin/grimblast copy area"
            # File manager
            "$mainMod, E, exec, ${pkgs.gnome.nautilus}/bin/nautilus"
            # Toggle the four different special workspaces.
            "$mainMod, B, togglespecialworkspace, btop"
            "$mainMod, V, togglespecialworkspace, pipewire"
            "$mainMod, N, togglespecialworkspace, nixos"
            "$mainMod, X, togglespecialworkspace, keepassxc"

            # Reload hyprland
            "$mainMod, R, exec, ${hyprland}/bin/hyprctl reload"
            # Restart waybar
            "$mainMod CONTROL, B, exec, ${pkgs.procps}/bin/pkill waybar || ${waybar}/bin/waybar"
          ];
          binde = [
            # window focus
            "$mainMod, H, movefocus, l"
            "$mainMod, J, movefocus, d"
            "$mainMod, K, movefocus, u"
            "$mainMod, L, movefocus, r"
          ];
          # Media controls
          bindl = let
            play-pause = "${pkgs.playerctl}/bin/playerctl play-pause";
            stop = "${pkgs.playerctl}/bin/playerctl stop";
            prev = "${pkgs.playerctl}/bin/playerctl previous";
            next = "${pkgs.playerctl}/bin/playerctl next";
            toggle-mute = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
          in [
            ", XF86AudioMedia, exec, ${play-pause}"
            ", XF86AudioPlay,  exec, ${play-pause}"
            ", XF86AudioStop,  exec, ${stop}"
            ", XF86AudioPrev,  exec, ${prev}"
            ", XF86AudioNext,  exec, ${next}"
            ", XF86AudioMute,  exec, ${toggle-mute}"
          ];

          # locked + repeat
          bindle = let
            volume_up = "${pkgs.pamixer}/bin/pamixer -ui 5";
            volume_down = "${pkgs.pamixer}/bin/pamixer -ud 5";
          in [
            ", XF86AudioRaiseVolume, exec, ${volume_up}"
            ", XF86AudioLowerVolume, exec, ${volume_down}"
          ];
          # Mouse settings
          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];
          # Some more movement-related settings
          binds = {
            pass_mouse_when_bound = false;
            movefocus_cycles_fullscreen = false;
          };
          # Programs which get executed at Hyprland start.
          exec-once = [
            #start waybar
            # "${waybar}/bin/waybar"

            # run persistent special workspace windows
            "[workspace special:nixos; silent;tile] ${foot}/bin/foot -D ~/repos/nichts nvim"

            "[workspace special:keepassxc; silent;tile] ${pkgs.keepassxc}/bin/keepassxc"

            "${swww}/bin/swww-daemon"
            "${wlsunset}/bin/wlsunset -S 06:00 -s 20:00"
            "${waybar}/bin/waybar"
          ];

          exec = [
            # kill (almost) everything on special workspaces
            "${pkgs.procps}/bin/pkill btop"
            "${pkgs.procps}/bin/pkill pavucontrol"
            # and run it all again
            "[workspace special:btop;silent;tile] ${foot}/bin/foot ${pkgs.btop}/bin/btop"

            #            "[workspace special:pipewire silent;tile] ${pkgs.helvum}/bin/helvum"
            "[workspace special:pipewire;silent;tile] ${pkgs.pavucontrol}/bin/pavucontrol"
            # "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
          ];
        };
      };
    };
    environment.systemPackages = with pkgs; [libnotify];
  };
}
