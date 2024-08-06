{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.waybar;
  inherit (config.modules.other.system) username;
in {
  options.modules.programs.waybar.enable = lib.mkEnableOption "waybar";
  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar;
        settings.mainBar = {
          gtk-layer-shell = true;
          layer = "top";
          position = "bottom";
          modules-left = ["tray" "mpd"];
          modules-center = ["hyprland/workspaces"];
          modules-right = [
            "cpu"
            "memory"
            "pulseaudio"
            "clock"
            "backlight"
            "battery"
          ];

          pulseaudio = {
            tooltip = false;
            scroll-step = "1";
            format = " {icon} {volume}%";
            format-muted = " 󰸈 {volume}%";
            format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
            on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };

          "hyprland/workspaces" = {
            sort-by-name = true;
            sort-by-coordinates = false;
            on-click = "activate";
            #on-scroll = "~/Scripts/cycle_workspace.sh 1";
            active-only = true;
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
            icon-size = 12;
            spacing = 5;
          };

          # 󰃰
          clock = {
            interval = 1;
            format = " {:%a  %d %b %H:%M:%S}";
          };

          battery = {
            interval = 10;
            states = {
              good = 75;
              warning = 20;
              critical = 10;
            };
            format = "{icon}{capacity}%";
            format-charging = "󰚥{icon}{capacity}%";
            format-discharging = "{icon}{capacity}%";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            format-charging-icons = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
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
          "hyprland/window" = {
            format = "{}";
            separate-outputs = true;
          };

          mpd = {
            format = "󰝚 {artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
            format-disconnected = "󰝚 Disconnected";
            format-stopped = "󰝚 Stopped";
            interval = 1;
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
            on-click = "mpc toggle";
          };
        };

        style = ''
          @define-color base   #000000;
          @define-color inactive #ab8f44;
          @define-color active #1565c0;

          @define-color text     #ffffff;

                    * {
              border-radius: 1px;
              font-family: ComicShannsMono Nerd Font;

              font-size: 16px;
          }

          window#waybar {
              background-color: alpha(@base, 1.0);
              border-radius: 0px;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          #window {
              margin-top: 2px;
              margin-bottom: 2px;
              padding-left: 2px;
              padding-right: 2px;
              background: @base;
              color: @text;
              font-family: ComicShannsMono Nerd Font;
          }

          #workspaces {
              padding-left: 5px;
          }

          #workspaces button {
              border-radius: 0px;
              padding-top: 0px;
              padding-right: 0px;
              padding-bottom: 0px;
              padding-left: 0px;
              margin-top: 2px;
              margin-right: 2px;
              margin-bottom: 2px;
              margin-left: 2px;
              background-color: @inactive;
              color: @text;
              min-width: 15px;
          }

          #workspaces button.active {
              padding-top: 0px;
              padding-bottom: 0px;
              padding-right: 0px;
              padding-left: 0px;
              margin-top: 2px;
              margin-right: 2px;
              margin-bottom: 2px;
              margin-left: 2px;
              background-color: @active;
              color: @base;
              min-width: 15px;
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
              margin-top: 2px;
              margin-bottom: 2px;
              margin-left: 2px;
              margin-right: 2px;
              padding-left: 0px;
              padding-right: 0px;
              transition: none;
              background: @base;
              color: @text;
          }

          #battery {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @base;
              color: @text;
          }

          @keyframes blink {
              to {
                  background-color: @red;
              }
          }

          #battery.charging, #battery.plugged {
              background-color: @base;
          }

          #battery.critical:not(.charging) {
              background-color: @base;
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
              background: @base;
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
              background: @base;
              color: @text;
          }

          #tray {
              margin-top: 2px;
              margin-bottom: 2px;
              margin-left: 2px;
              padding-left: 2px;
              padding-right: 2px;
              transition: none;
              background: @base;
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
              background: @base;
              color: @red;
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

          #mpd {
              margin-top: 3px;
              margin-bottom: 3px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              transition: none;
              background: @base;
              color: @text;
          }
        '';
      };
    };
  };
}
