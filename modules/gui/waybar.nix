{ config, lib, inputs, pkgs, ... }:
with lib;
let
  cfg = config.modules.programs.waybar;
  inherit (config.modules.other.system) username;
in {
  options.modules.programs.waybar.enable = mkEnableOption "waybar";
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.waybar = {
        enable = true;
        package = inputs.waybar.packages.${pkgs.system}.waybar;
        settings.mainBar = {
          gtk-layer-shell = true;
          layer = "top";
          modules-left = [ "clock" "custom/launcher" "tray" "hyprland/window" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [ # "custom/dnd"
            "mpd"
            "cpu"
            "memory"
            "pulseaudio"
          ];

          pulseaudio = {
            tooltip = false;
            scroll-step = "1";
            format = " {icon} {volume}%";
            format-muted = " 󰸈 {volume}%";
            format-icons = { default = [ "󰕿" "󰖀" "󰕾" ]; };
            on-click =
              "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };
          "hyprland/workspaces" = {
            sort-by-name = true;
            sort-by-coordinates = false;
            on-click = "activate";
            #on-scroll = "~/Scripts/cycle_workspace.sh 1";
            active-only = false;
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "10" = "10";
              "11" = "1";
              "12" = "2";
              "13" = "3";
              "14" = "4";
              "15" = "5";
              "16" = "6";
              "17" = "7";
              "18" = "8";
              "19" = "9";
              "20" = "10";
              "21" = "1";
              "22" = "2";
              "23" = "3";
              "24" = "4";
              "25" = "5";
              "26" = "6";
              "27" = "7";
              "28" = "8";
              "29" = "9";
              "30" = "10";
            };
          };
          tray = {
            icon-size = 18;
            spacing = 8;
          };
          # 󰃰 
          clock = {
            interval = 1;
            format = " {:%a  %d %b %H:%M:%S}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              on-click-right = "mode";
              format = {
                months = "<span color='#EBDBB2'><b>{}</b></span>";
                days = "<span color='#B16286'><b>{}</b></span>";
                weeks = "<span color='#458588'><b>T{:%W}</b></span>";
                weekdays = "<span color='#D79921'><b>{}</b></span>";
                today = "<span color='#CC241D'><b><u>{}</u></b></span>";
              };
              actions = {
                on-click-right = "mode";
                on-cck-forward = "tz_up";
                on-click-backward = "tz_down";
                on-scroll-up = "shift_up";
                on-scroll-down = "shift_down";
              };
            };
          };
          cpu = {
            interval = 1;
            format = "󰻠 {}%";
            max-length = 10;
          };
          memory = {
            interval = 1;
            format = "󰍛 {}%";
            max-length = 10;
          };
          "custom/launcher" = {
            format = " ";
            on-click = "anyrun";
            on-click-right = "pkill anyrun";
          };
          "hyprland/window" = {
            format = "{}";
            separate-outputs = true;
          };
          cava = {
            framerate = 60;
            autosens = 0;
            sensitivity = 7;
            bars = 14;
            lower_cutoff_freq = 50;
            higher_cutoff_freq = 10000;
            method = "pipewire";
            source = "auto";
            stereo = true;
            reverse = false;
            bar_delimiter = 0;
            monstercat = false;
            waves = false;
            noise_reduction = 0.77;
            input_delay = 0;
            format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
            actions = { on-click-right = "mode"; };
          };
          "custom/xwayland" = {
            exec = "${
                inputs.hyprland.packages.${pkgs.system}.hyprland
              }/bin/hyprctl clients | ${pkgs.ripgrep}/bin/rg -e 'xwayland: [1]' | ${pkgs.coreutils-full}/bin/wc -l";
            interval = 1;
            format = "X {}";
          };
          mpd = {
            format =
              "󰝚 {artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
            format-disconnected = "󰝚 Disconnected";
            format-stopped = "󰝚 Stopped";
            interval = 1;
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
            on-click = "mpc toggle";
          };
        };
        style = ''
          @define-color base   #1e1e2e;
          @define-color mantle #181825;
          @define-color crust  #11111b;

          @define-color text     #cdd6f4;
          @define-color subtext0 #a6adc8;
          @define-color subtext1 #bac2de;

          @define-color surface0 #313244;
          @define-color surface1 #45475a;
          @define-color surface2 #585b70;

          @define-color overlay0 #6c7086;
          @define-color overlay1 #7f849c;
          @define-color overlay2 #9399b2;

          @define-color blue      #89b4fa;
          @define-color lavender  #b4befe;
          @define-color sapphire  #74c7ec;
          @define-color sky       #89dceb;
          @define-color teal      #94e2d5;
          @define-color green     #a6e3a1;
          @define-color yellow    #f9e2af;
          @define-color peach     #fab387;
          @define-color maroon    #eba0ac;
          @define-color red       #f38ba8;
          @define-color mauve     #cba6f7;
          @define-color pink      #f5c2e7;
          @define-color flamingo  #f2cdcd;
          @define-color rosewater #f5e0dc;

          * {
              border-radius: 1px;
              font-family: JetBrains Mono;
              /* font-family: Material Design Icons; */

              font-size: 16px;
          }

          window#waybar {
              background-color: alpha(@base, 0.0);
              border-radius: 0px;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          #window {
              margin-top: 4px;
              margin-bottom: 4px;
              padding-left: 10px;
              padding-right: 10px;
              background: @mantle;
              color: @teal;
              font-family: JetBrains Mono;
          }

          #workspaces {
              padding-left: 5px;
          }

          #workspaces button {
              border-radius: 15px;
              padding-top: 0px;
              padding-right: 0px;
              padding-bottom: 0px;
              padding-left: 0px;
              margin-top: 4px;
              margin-right: 3px;
              margin-bottom: 4px;
              margin-left: 3px;
              background-color: @mantle;
              color: @text;
              min-width: 15px;
          }

          #workspaces button.active {
              padding-top: 0px;
              padding-bottom: 0px;
              padding-right: 0px;
              padding-left: 0px;
              margin-top: 4px;
              margin-right: 3px;
              margin-bottom: 4px;
              margin-left: 3px;
              background-color: @blue;
              color: @mantle;
              min-width: 15px;
          }

          #workspaces button:hover {
              background: alpha(@mantle, 0.7);
              transition-property: background, min-width;
              transition-duration: 0.5s;
              transition-timing-function: ease;
          }

          #workspaces button.focused {
              background-color: @yellow;
          }

          #workspaces button.urgent {
              background-color: @red;
          }

          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

          .modules-right > widget:first-child > #workspaces {
              margin-right: 0;
          }

          #pulseaudio {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 0px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
              color: @peach;
              /*border-top-left-radius: 0;
              border-bottom-left-radius: 0;*/
          }

          #cava {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              margin-right: 0px;
              padding-left: 10px;
              padding-right: 0px;
              transition: none;
              background: @mantle;
              color: @peach;
              border-top-right-radius: 0;
              border-bottom-right-radius: 0;
          }

          #battery {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
              color: @teal;
          }

          @keyframes blink {
              to {
                  background-color: @red;
              }
          }

          #battery.charging, #battery.plugged {
              background-color: @mantle;
          }

          #battery.critical:not(.charging) {
              background-color: @mantle;
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          #backlight {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
              color: @yellow;
          }
          #clock {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition-property: min-width;
              transition-duration: 0.5s;
              background: @mantle;
              color: @pink;
          }

          #custom-power_profile {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
              color: @rosewater;
          }

          #tray {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
          }

          #custom-launcher {
              font-size: 16px;
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 5px;
              transition: none;
              background: @mantle;
              color: @blue;
          }

          #custom-power {
              font-size: 20px;
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              margin-right: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
              color: @red;
          }

          #custom-wallpaper {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
          }

          #custom-updates {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
          }

          #custom-media {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
          }

          #custom-dnd {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
              color: @flamingo;
          }

          #custom-xwayland {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
              color: @green;
          }

          #mpd {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @mantle;
              color: @green;
          }
        '';
      };
    };
  };
}

