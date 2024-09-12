{
  config,
  lib,
  pkgs,
  self',
  ...
}: let
  cfg = config.modules.system.programs.terminals.foot;
  inherit (config.modules.other.system) username;

  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        libsixel # for displaying images
      ];
      programs.foot = {
        enable = true;
        server.enable = false;
        package = pkgs.foot;
        settings = {
          main = {
            term = "foot";
            app-id = "foot";
            title = "foot";
            locked-title = "no";
            shell = "${self'.packages.nushell}/bin/nu";

            font = "Iosevka Nerd Font:size=14";
            font-bold = "Iosevka Nerd Font:size=14";

            selection-target = "primary";
            dpi-aware = false;
            pad = "0x0 center";
          };

          desktop-notifications.command = "${pkgs.libnotify}/bin/notify-send -a \${app-id} -i \${app-id} \${title} \${body}";

          bell = {
            urgent = "yes";
            notify = "yes";
            command = "${pkgs.libnotify}/bin/notify-send bell";
            command-focused = "no";
          };

          scrollback = {
            lines = 10000;
            multiplier = 10.0;
            indicator-position = "relative";
            indicator-format = "line";
          };

          url = {
            launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
            label-letters = "sadfjklewcmpgh";
            osc8-underline = "always";
            protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";
            uri-characters = ''
              abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+="'()[]'';
          };

          tweak = {
            font-monospace-warn = "no";
            sixel = "yes";
          };
          cursor = {
            style = "beam";
            blink = "true";
          };

          mouse = {
            hide-when-typing = "yes"; # not really needed since we already enable this in Hyprland.
            alternate-scroll-mode = "yes";
          };
        };
      };
    };
  };
}
