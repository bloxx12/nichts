{
  config,
  pkgs,
  lib,
  inputs',
  ...
}: let
  cfg = config.modules.usrEnv.desktops.hyprland;
  inherit (config.modules.other.system) username;
  inherit (config.modules.style) cursor;
  inherit (config.modules.system.hardware) monitors;

  inherit
    (inputs'.split-monitor-workspaces.packages)
    split-monitor-workspaces
    ;
  inherit (lib) imap0 flatten optionalString mkIf mkDefault mapAttrsToList;
  inherit (builtins) map genList attrNames toString;
in {
  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = false;
      inherit (cfg) package portalPackage;
    };
    # xdg Portal
    xdg.portal = {
      enable = true;
      configPackages = mkDefault [
        inputs'.hyprland.packages.xdg-desktop-portal-hyprland
      ];
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        inputs'.hyprland.packages.xdg-desktop-portal-hyprland
      ];
      config = {
        common.default = ["hyprland"];
      };
    };
    home-manager.users.${username} = {
      wayland.windowManager.hyprland = {
        enable = true;
        inherit (cfg) package;

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
          # monitor = [
          #   "eDP-1,1920x1080,0x0,1"
          #   # "DP-2,1920x1080,0x0,1"
          #   # "HDMI-A-2,1920x1080,1920x0,1"
          #   # "HDMI-A-1,1920x1080,3840x0,1"
          #   # Had the shadow monitor bug, so had to disable all unknown monitors.
          #   "Unknown-1,disable"
          # ];

          # Thanks Poz for inspiration, using an attrset is actually much smarter
          # than using a normal list.
          monitor =
            mapAttrsToList (
              name: m: let
                w = toString m.resolution.x;
                h = toString m.resolution.y;
                refreshRate = toString m.refreshRate;
                x = toString m.position.x;
                y = toString m.position.y;
                scale = toString m.scale;
              in "${name},${w}x${h}@${refreshRate},${x}x${y},${scale}"
            )
            monitors;

          # INFO: This is a custom function to map all of my monitors to workspaces.
          # Since I use split-monitor-workspaces, I map 10 workspaces to each monitor
          # and set the first one to be the default one.
          # To be able to use this for a varying amount of monitors we do some nasty trickery:
          workspace =
            # We're creating several lists of workspace assignments, one for each monitor,
            # and have to merge them into one big list.
            (flatten
              # We then use imap0 insted of map because imap0 starts indexing at zero as oppsed to one with map.
              (imap0 (monitorIndex: monitorName: (
                  map (
                    i: let
                      # we define our own modulo operation for this,
                      # since only the first workspace on each monitor is the default workspace.
                      mod = a: b: a - (b * (a / b));
                      workspace = toString i;
                      isDefault = (mod i 10) == 1; # 11, 21, 31, ...
                    in "${workspace}, monitor:${monitorName}${optionalString isDefault ", default:true"}"
                  )
                  # we generate a list of 10 elements for each monitor. We have to add 1 each time since genList starts indexing at 0.
                  # also, we add the monitorIndex * 10 to get 10 workspaces for each individual monitor.
                  (genList (i: i + 1 + (10 * monitorIndex)) 10)
                ))
                # our attrSet of different monitors
                (attrNames monitors)))
            # These are my two special workspaces
            ++ [
              "special:nixos, decorate:false"
              "special:keepassxc, decorate:false"
            ];

          # Input settings
          input = {
            kb_layout = "de,us";
            kb_variant = ",colemak_dh_wide";
            kb_options = "grp:rctrl_rshift_toggle";

            follow_mouse = true;

            repeat_rate = 50;
            repeat_delay = 200;

            touchpad = {
              disable_while_typing = true;
            };
          };

          general = {
            gaps_in = 0;
            gaps_out = 0;
            border_size = 2;

            no_border_on_floating = true;
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

          cursor = {
            hide_on_key_press = true;
            no_hardware_cursors = true;
          };

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
          bind =
            # workspaces
            # split-workspace is because of the split-workspace plugin
            map (
              i: let
                mod = a: b: a - (b * (a / b));
                key = toString (mod i 10);
                workspace = toString i;
              in "$mainMod, ${key}, split-workspace, ${workspace}"
            ) (genList (i: i + 1) 10)
            # split-movetoworkspacesilent
            ++ map (
              i: let
                mod = a: b: a - (b * (a / b));
                key = toString (mod i 10);
                workspace = toString i;
              in "$mainMod SHIFT, ${key}, split-movetoworkspacesilent, ${workspace}"
            ) (genList (i: i + 1) 10)
            ++ [
              "$mainMod, RETURN, exec, ${pkgs.foot}/bin/foot"
              "$mainMod, Q, killactive"
              "$mainMod, F, fullscreen, 0"
              "$mainMod, D, exec, ${pkgs.procps}/bin/pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"
              "$mainMod, SPACE, togglefloating, active"

              # Move Windows
              "$mainMod SHIFT, H, movewindow, l"
              "$mainMod SHIFT, J, movewindow, d"
              "$mainMod SHIFT, K, movewindow, u"
              "$mainMod SHIFT, L, movewindow, r"

              # Screenshotting
              "$mainMod, S, exec, ${pkgs.grimblast}/bin/grimblast copy area"

              # File manager
              "$mainMod, E, exec, ${pkgs.xfce.thunar}/bin/thunar"

              # Toggle the three different special workspaces.
              "$mainMod, N, togglespecialworkspace, nixos"
              "$mainMod, X, togglespecialworkspace, keepassxc"

              # Reload hyprland
              "$mainMod, R, exec, ${cfg.package}/bin/hyprctl reload"

              # Restart waybar
              "$mainMod CONTROL, B, exec, ${pkgs.procps}/bin/pkill waybar || ${pkgs.waybar}/bin/waybar"
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
            brightness_up = "${pkgs.brightnessctl}/bin/brightnessctl set +10%";
            brightness_down = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
          in [
            ", XF86AudioRaiseVolume, exec, ${volume_up}"
            ", XF86AudioLowerVolume, exec, ${volume_down}"
            ", XF86MonBrightnessUp, exec, ${brightness_up}"
            ", XF86MonBrightnessDown, exec, ${brightness_down}"
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
            "hyprctl setcursor ${cursor.name} ${toString cursor.size}"
            #start waybar
            "${pkgs.waybar}/bin/waybar"

            # run persistent special workspace windows
            "[workspace special:nixos; silent;tile] ${pkgs.foot}/bin/foot -D ~/projects/nichts"

            "[workspace special:keepassxc; silent;tile] ${pkgs.keepassxc}/bin/keepassxc"

            "${pkgs.swww}/bin/swww-daemon"

            "${pkgs.wlsunset}/bin/wlsunset -S 06:00 -s 20:00"
          ];

          exec = [
          ];

          plugin = {
            split-monitor-workspaces = {
              keep-focued = true;
              count = 10;
            };
          };
        };
      };
    };
  };
}
