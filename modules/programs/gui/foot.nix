{
  config,
  inputs',
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.terminals.foot;
  inherit (config.modules.other.system) username;

  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.sessionVariables.TERM = "foot";
      programs.foot = {
        enable = true;
        package = inputs'.nixpkgs-wayland.packages.foot;
        settings = {
          main = {
            term = "foot";
            app-id = "foot";
            title = "foot";
            locked-title = "no";

            font = "ComicShannsMono Nerd Font:size=14";

            # line-height = 20;
            letter-spacing = 0;
            horizontal-letter-offset = 0;
            vertical-letter-offset = -0.75;
            box-drawings-uses-font-glyphs = "no";
            dpi-aware = "no";

            initial-window-size-chars = "104x36";
            initial-window-mode = "windowed";
            pad = "5x5 center";
            resize-delay-ms = 100;

            bold-text-in-bright = "no";
            word-delimiters = '',│`|:"'()[]{}<>'';
            selection-target = "primary";
          };

          desktop-notifications.command = "${pkgs.libnotify}/bin/notify-send -a \${app-id} -i \${app-id} \${title} \${body}";

          bell = {
            urgent = "yes";
            notify = "yes";
            command = "${pkgs.libnotify}/bin/notify-send bell";
            command-focused = "no";
          };

          scrollback = {
            lines = 100000;
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

          cursor = {
            style = "beam";
            blink = "true";
          };

          mouse = {
            hide-when-typing = "yes"; # not really needed since we already enable this in Hyprland
            alternate-scroll-mode = "yes";
          };

          csd = {preferred = "server";};

          key-bindings = {
            show-urls-launch = "Control+Shift+u";
            unicode-input = "Control+Shift+i";
          };
        };
      };
    };
  };
}
