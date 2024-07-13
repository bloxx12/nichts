{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.foot;
  inherit (config.modules.other.system) username;

  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.programs.foot = {
    enable = mkEnableOption "foot";
    server = mkEnableOption "foot server mode";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {TERM = "foot";};
    home-manager.users.${username} = {
      programs.foot = {
        enable = true;
        package = inputs.nixpkgs-wayland.packages.${pkgs.system}.foot;
        server.enable = cfg.server;
        settings = {
          main = {
            term = "foot";
            app-id = "foot";
            title = "foot";
            locked-title = "no";

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

            notify = "${pkgs.libnotify}/bin/notify-send -a \${app-id} -i \${app-id} \${title} \${body}";

            bold-text-in-bright = "no";
            word-delimiters = '',│`|:"'()[]{}<>'';
            selection-target = "primary";
          };
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
            style = "block";
            blink = "true";
          };
          mouse = {
            hide-when-typing = "yes";
            alternate-scroll-mode = "yes";
          };
          # colors = {
          #   alpha = 0.85;
          #   foreground = "cdd6f4"; # Text
          #   background = "1e1e2e"; # Base
          #   regular0 = "45475a"; # Surface 1
          #   regular1 = "f38ba8"; # red
          #   regular2 = "a6e3a1"; # green
          #   regular3 = "f9e2af"; # yellow
          #   regular4 = "89b4fa"; # blue
          #   regular5 = "f5c2e7"; # pink
          #   regular6 = "94e2d5"; # teal
          #   regular7 = "bac2de"; # Subtext 1
          #   bright0 = "585b70"; # Surface 2
          #   bright1 = "f38ba8"; # red
          #   bright2 = "a6e3a1"; # green
          #   bright3 = "f9e2af"; # yellow
          #   bright4 = "89b4fa"; # blue
          #   bright5 = "f5c2e7"; # pink
          #   bright6 = "94e2d5"; # teal
          #   bright7 = "a6adc8"; # Subtext 0
          # };
          csd = {preferred = "server";};
          key-bindings = {
            show-urls-launch = "Control+Shift+u";
            unicode-input = "Control+Shift+i";
          };
          mouse-bindings = {
            # selection-override-modifiers = "Shift";
            # primary-paste = "BTN_MIDDLE";
            # select-begin = "BTN_LEFT";
            # select-begin-block = "Control+BTN_LEFT";
            # select-extend = "BTN_RIGHT";
            # select-extend-character-wise = "Control+BTN_RIGHT";
            # select-word = "BTN_LEFT-2";
            # select-word-whitespace = "Control+BTN_LEFT-2";
            # #select-row = "BTN_LEFT-3";
          };
        };
      };
    };
  };
}
