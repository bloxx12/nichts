{
  config,
  lib,
  pkgs,
  self',
  ...
}: let
  cfg = config.modules.system.programs.terminals.foot;
  inherit (config.modules.other.system) username;
  inherit (config.modules.style.colorScheme) colors;

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
            shell = "${self'.packages.fish}/bin/fish";

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
          # colors = with colors; {
          #   background = base00; # base color
          #   foreground = base05; # text color

          #   regular0 = base03; # black
          #   regular1 = base08; # red
          #   regular2 = base0B; # green
          #   regular3 = base0A; # yellow
          #   regular4 = base0D; # blue
          #   regular5 = base0F; #magenta
          #   regular6 = base0C; #cyan
          #   regular7 = base06; #white

          #   bright0 = base04; # Surface 2
          #   bright1 = base08; # red
          #   bright2 = base0B; # green
          #   bright3 = base0A; # yellow
          #   bright4 = base0D; # blue
          #   bright5 = base0F; # pink
          #   bright6 = base0C; # teal
          #   bright7 = base07; # Subtext 0

          #   alpha = 0.85;
          # };
        };
      };
    };
  };
}
