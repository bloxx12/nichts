{ config, lib, pkgs, ... }: 

with lib;
let
  username = config.modules.other.system.username;
in
{
  environment.systemPackages = with pkgs; [ waybar ];
  home-manager.users.${username} = {
    programs.waybar = {
      systemd.enable = true;
      settings = {
          main = {
            layer = "top";
            position = "top";
            modules-left = [
              "custom/os-icon"
              "hyprland/workspaces"
            ];
            modules-center = [
              "backlight"
              "clock#time"
              "wireplumber"
            ];
            modules-right = [
              "tray"
              "network"
              "battery"
            ];
            #  Modules
            "custom/os-icon" = {
              format = "\\uf313"; #NixOS logo
            };
            battery =  {
              interval = 10;
              states = {
                warning = 30;
                critical = 15;
              };
              format-time =  "{H}:{M:02}";
              format = "{icon}    {capacity}%";
              format-charging =  " {capacity}%";
              format-charging-full = " {capacity}%";
              format-full = "{icon} {capacity}%";
              format-icons =  [
                ""
                ""
                ""
                ""
                ""
              ];
              tooltip = false;
            };
            "clock#time" = {
              interval = 10;
              format = "{:%H:%M}";
              tooltip =  false;
            };
            "clock#date" = {
              interval = 20;
              format = "{:%d.%m.%Y}";
              tooltip = false;
            };
            memory =  {
              interval = 5;
              format = " {used:0.1f}G/{total:0.1f}G";
              states = {
                warning = 70;
                critical = 90;
              };
              tooltip = false;
            };
            network = {
              interval = 5;
              format-wifi = "{icon} {essid}";
              format-ethernet = "\\udb80\\ude01 {ifname}";
              format-disconnected = "\\uf0202 Offline";
              format-alt = "\\udb80\\uddda {bandwidthDownBytes} \\udb81\\udd52 {bandwidthUpBytes} \\udb82\\ude5f {ipaddr}/{cidr}";
              format-icons = [
                "\\udb82\\udd28 "
                "\\udb82\\udd25 "
                "\\udb82\\udd22 "
                "\\udb82\\udd1f "
                "\\udb82\\udd2f "
              ];
              tooltip = false;
            };
            "hyprland/mode" = {
              format = "test{}";
              tooltip = false;
            };
            "hyprland/window" = {
              format = "{}";
              max-length = 30;
              tooltip = false;
              rewrite = {
                "([Aa]lacritty|kitty)" = "\\ue795 $1";
                "(.*) .{15} Mozilla Firefox" = "\\ue745 $1";
                "(^Spotify.*)" = "\\uf1bc $1";
              };
            };
            "hyprland/workspaces" = {
              disable-scroll-wraparound = true;
              smooth-scrolling-threshold = 4;
              enable-bar-scroll = true;
              format = "{icon}";
              format-icons = {
                "1" = "Ⅰ";
                "2" = "Ⅱ";
                "3" = "Ⅲ";
                "4" = "Ⅳ";
                "5" = "Ⅴ";
                "6" = "Ⅵ";
                "7" = "Ⅶ";
                "8" = "Ⅷ";
                "9" = "Ⅸ";
                "10" = "Ⅹ";
                "11" = "Ⅺ";
                "12" = "Ⅻ";
              };
            };
            "pulseaudio/slider" = {
              min = 0;
              max = 100;
              orientation = "horizontal";
            };
            pulseaudio = {
              format = "{icon} {volume}%";
              format-bluetooth = "{icon} {volume}%";
              format-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                  ""
                  ""
                ];
              };
              scroll-step = 1;
              on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
              tooltip = false;
            };
            user = {};
            temperature = {
              critical-threshold = 90;
              interval = 5;
              format = " {icon} {temperatureC}°";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
              tooltip = false;
            };
            backlight = {
              format = "{percent}% {icon} ";
              format-icons = [
                "\\udb80\\udf36"
                "\\udb86\\ude4e"
                "\\udb86\\ude4f"
                "\\udb86\\ude50"
                "\\udb86\\ude51"
                "\\udb86\\ude52"
                "\\udb86\\ude53"
                "\\udb86\\ude54"
                "\\udb86\\ude55"
                "\\udb86\\ude56"
                "\\udb81\\udee8"
              ];
            };
            wireplumber = {
              format = "{icon} {volume}%";
              format-muted = "\\udb81\\udd81";
              format-icons = [
                "\\uf026"
                "\\uf027"
                "\\udb81\\udd7e"
              ];
            };
            tray = {
              icon-size = 18;
            };
          };
        };

    };
    


  };
}
